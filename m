From: Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] fscrypto: move ioctl processing more fully into common
 code
Date: Tue, 22 Nov 2016 15:15:36 -0800
Message-ID: <20161122231536.GA26438@google.com>
References: <1476723246-47420-1-git-send-email-ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ext4-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476723246-47420-1-git-send-email-ebiggers@google.com>
Sender: linux-ext4-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu, jaegeuk@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, Oct 17, 2016 at 09:54:06AM -0700, Eric Biggers wrote:
> Multiple bugs were recently fixed in the "set encryption policy" ioctl.
> To make it clear that fscrypt_process_policy() and fscrypt_get_policy()
> implement ioctls and therefore their implementations must take standard
> security and correctness precautions, rename them to
> fscrypt_ioctl_set_policy() and fscrypt_ioctl_get_policy().  Make the
> latter take in a struct file * to make it consistent with the former.
> 
> In addition, make the common functions do the copies to and from
> userspace rather than duplicating this code within each filesystem, and
> memset the policy to 0 to make it clear there is no stack leak.
> 

Ted, do you have any interest in taking this patch for 4.10?

Thanks,

Eric
