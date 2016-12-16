From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 2/3] fscrypt: fix renaming and linking special files
Date: Fri, 16 Dec 2016 13:22:55 +0100
Message-ID: <078aca9a-5239-18dd-6317-9d6f03c42770@nod.at>
References: <1481829584-50218-1-git-send-email-ebiggers3@gmail.com>
 <1481829584-50218-2-git-send-email-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ext4-owner@vger.kernel.org>
In-Reply-To: <1481829584-50218-2-git-send-email-ebiggers3@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, David Gstir <david@sigma-star.at>, Eric Biggers <ebiggers@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 15.12.2016 20:19, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Attempting to link a device node, named pipe, or socket file into an
> encrypted directory through rename(2) or link(2) always failed with
> EPERM.  This happened because fscrypt_permitted_context() saw that the
> file was unencrypted and forbid creating the link.  This behavior was
> unexpected because such files are never encrypted; only regular files,
> directories, and symlinks can be encrypted.
> 
> To fix this, make fscrypt_has_permitted_context() always return true on
> special files.
> 
> This will be covered by a test in my encryption xfstests patchset.
> 
> Fixes: 9bd8212f981e ("ext4 crypto: add encryption policy and password salt support")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

