From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 1/7] ext4: use IS_ENCRYPTED() to check
 encryption status
Date: Mon, 26 Nov 2018 16:35:11 -0800
Message-ID: <20181127003510.GD11663@gmail.com>
References: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
 <20181119052324.31456-2-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1gRRLU-0003n3-18
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 00:35:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRRLS-00GXka-Of
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 00:35:19 +0000
Content-Disposition: inline
In-Reply-To: <20181119052324.31456-2-chandan@linux.vnet.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net

Hi Chandan,

On Mon, Nov 19, 2018 at 10:53:18AM +0530, Chandan Rajendra wrote:
> @@ -4724,7 +4724,7 @@ static bool ext4_should_use_dax(struct inode *inode)
>  		return false;
>  	if (ext4_has_inline_data(inode))
>  		return false;
> -	if (ext4_encrypted_inode(inode))
> +	if (IS_ENCRYPTED(inode))
>  		return false;
>  	if (ext4_verity_inode(inode))
>  		return false;

I think this part is wrong.  See how ext4_should_use_dax() is called from
ext4_set_inode_flags(), from ext4_set_context().  In this case,
ext4_set_inode_flags() should set S_ENCRYPTED and clear S_DAX.  However, you've
changed ext4_should_use_dax() to check S_ENCRYPTED instead of EXT4_ENCRYPT_FL;
but S_ENCRYPTED isn't set until later in ext4_set_inode_flags(), so S_DAX won't
be cleared anymore.

So I think you need to use ext4_test_inode_flag() here instead.

Similarly for the verity check.

- Eric
