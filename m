From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] fscrypto: lock inode while setting encryption policy
Date: Thu, 29 Sep 2016 19:20:20 +0200
Message-ID: <ea8b7140-f04e-380d-b5ae-263f029c0624@nod.at>
References: <1475087688-4048-1-git-send-email-ebiggers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ext4-owner@vger.kernel.org>
In-Reply-To: <1475087688-4048-1-git-send-email-ebiggers@google.com>
Sender: linux-ext4-owner@vger.kernel.org
To: Eric Biggers <ebiggers@google.com>, linux-fsdevel@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, tytso@mit.edu, jaegeuk@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 28.09.2016 20:34, Eric Biggers wrote:
> i_rwsem needs to be acquired while setting an encryption policy so that
> concurrent calls to FS_IOC_SET_ENCRYPTION_POLICY are correctly
> serialized (especially the ->get_context() + ->set_context() pair), and
> so that new files cannot be created in the directory during or after the
> ->empty_dir() check.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
