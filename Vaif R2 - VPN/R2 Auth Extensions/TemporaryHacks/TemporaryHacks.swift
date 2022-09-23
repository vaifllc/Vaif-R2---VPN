//
//  TemporaryHacks.swift
//  Vaif R2 - VPN
//
//  Created by VAIF on 9/22/22.
//

#if DEBUG

public enum TemporaryHacks {
    // Can be used only for core example app internal tests
    public static var signupMode: SignupMode?
}

#else

public enum TemporaryHacks {
    // Can be used only for core example app internal tests
    public static let signupMode: SignupMode? = nil
}

#endif
