From: Eric Biggers <ebiggers@google.com>
Subject: Re: [RFD] Common userspace tool for fscypto
Date: Tue, 29 Nov 2016 16:04:07 -0800
Message-ID: <20161130000407.GB107713@google.com>
References: <0bef3877-060e-b722-0354-3a5508219e23@nod.at>
 <CA+POJK10M3_GhP_Ge4qkQF4gSNMUXVr5kem9Ak4EDmVRvRUg7g@mail.gmail.com>
 <f9bc005b-4e25-d705-e091-5f930e4246b1@nod.at>
 <CAKpBdu1+k94WmwxeZ2Hyu5=ifNprPA0YedRm2xps-ooyVHTwhg@mail.gmail.com>
 <87d9b3aa-684d-856a-0dcd-f960923f2484@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ext4-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d9b3aa-684d-856a-0dcd-f960923f2484@nod.at>
Sender: linux-ext4-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Joe Richey <joerichey@google.com>, Michael Halcrow <mhalcrow@google.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kzak@redhat.com, Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, David Gstir <david@sigma-star.at>, Ext4 Developers List <linux-ext4@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Nov 29, 2016 at 10:59:28PM +0100, Richard Weinberger wrote:
> 
> Do you also plan to address d/page cache related issues?
> i.e. when two users are logged into the system user rw
> is able to see decrypted file names and contents in /home/dags/
> if user dags installs a key and accessed a file.
> 

As far as I know, there are no plans to make it possible for one user to see
plaintext while another user sees ciphertext.  Fundamentally, the dentry, inode,
and page caches are shared systemwide.  This cannot be changed by using
namespaces; it can only be changed by doing something like an ecryptfs-style
stacked mount where the plaintext and ciphertext are actually exposed by
different filesystems.  And it was a fundamental design goal of ext4 encryption
to not do a stacked mount.

So the expectation is that to restrict access by other users once a key has been
provisioned, file permissions should be used.

> Or files in /home/dags/ are still readable even after
> user dags purged the key.

If you revoke the key (with 'keyctl revoke') rather than unlink the key (with
'keyctl unlink') then it actually does appear to work currently.  The difference
is that revoking the key is a modification of the key, whereas unlinking the key
is only removing a link to the key without affecting any links which the kernel
may have internally or which userspace may have in other keyrings.  Revocation
(but not unlinking) is detected by fscrypt_get_encryption_info() when someone
tries to open an encrypted file or directory.  There's also a d_revalidate
dentry operation which cause a dentry to be invalidated if it's a plaintext name
but the directory key is no longer valid, or if it's a ciphertext name but the
directory key is now valid.

There is however still work needed to make key revocation interact sanely with
ongoing filesystem operations.

Eric
