// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

namespace Microsoft.Quantum.Examples.Teleportation {
	open Microsoft.Quantum.Primitive;

    //////////////////////////////////////////////////////////////////////////
    // Introduction //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////

    // TODO: write a short summary here.

    //////////////////////////////////////////////////////////////////////////
    // Teleportation /////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////

    // We approach teleportation in two steps. First, we define how to
    // teleport the state of a qubit to another qubit. To do so, we define
    // teleportation as an operation, one of the fundamental building blocks
    // of a Q? program.

    // Most operations which act on qubits to modify their state in some way
    // will not return any useful information to the caller. We represent this
    // by a return value of (), meaning the empty tuple. Since all operations
    // take a tuple and return a tuple, that represents that the return value
    // is unimportant.
    
    /// # Summary
    /// Sends the state of one qubit to a target qubit by using
    /// teleportation.
    ///
    /// # Input
    /// ## msg
    /// A qubit whose state we wish to send.
    /// ## there
    /// A qubit intitially in the |0> state that we want to send
    /// the state of msg to.
	operation Teleport(msg : Qubit, there : Qubit) : () {
        body {

            using (register = Qubit[1]) {
				// Ask for an auxillary qubit that we can use to prepare
                // for teleportation.
				let here = register[0];
            
                // Create some entanglement that we can use to send our message.
                H(here);
                CNOT(here, there);
            
                // Move our message into the entangled pair.
                CNOT(msg, here);
                H(msg);

                // Measure out the entanglement.
                if (M(msg) == One)  { Z(there); }
				if (M(here) == One) { X(there); }
            }

		}
	}

    // TODO: finish prose here.

    /// # Summary
    /// Uses teleportation to send a classical message from one qubit
    /// to another.
    ///
    /// # Input
    /// ## message
    /// If `true`, the source qubit (`here`) is prepared in the
    /// |1> state, otherwise the source qubit is prepared in |0>.
    ///
    /// ## Output
    /// The result of a Z-basis measurement on the teleported qubit,
    /// represented as a Bool.
	operation TeleportClassicalMessage(message : Bool) : Bool {
        body {
			mutable measurement = false;

            using (register = Qubit[2]) {
				// Ask for some qubits that we can use to teleport.
				let msg = register[0];
				let there = register[1];
                
				// Encode the message we want to send.
				if (message) { X(msg); }
            
                // Use the operation we defined above.
                Teleport(msg, there);

				// Check what message was sent.
				if (M(there) == One) { set measurement = true; }
            }

			return measurement;
		}
	}

    /// # Summary
    /// Uses teleportation to send a qubit in the state R_x(f) |0>
    /// for some f ? [0, 2p), and fails if the state is not sent successfully.
    ///
    /// # Input
    /// ## message
    /// An angle f by which the inititial state |0> is to be rotated before sending.
    ///
    /// The result of a Z-basis measurement on the teleported qubit,
    /// represented as a Bool.
	operation TeleportRotation(message : Double) : () {
        body {
			//mutable measurement = false;

            //using (register = Qubit[2]) {
				// Ask for some qubits that we can use to teleport.
			//	let msg = register[0];
			//	let there = register[1];
                
			//	// Encode the message we want to send.
			//	if (message) { X(msg); }
            
                // Use the operation we defined above.
             //   Teleport(msg, there);

				// Check what message was sent.
			//	if (M(there) == One) { set measurement = true; }
            //}

			//return measurement;
		}
	}

}