From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH v3] f2fs crypto: allocate buffer for
 decrypting filename
Date: Wed, 16 Sep 2015 18:11:02 +0800
Message-ID: <000901d0f068$1a1bd100$4e537300$@samsung.com>
References: <1441936062-69511-1-git-send-email-jaegeuk@kernel.org>
	<20150911224550.GA73045@jaegeuk-mac02.mot.com>
	<20150915165215.GA82346@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Zc9h1-0003o3-E3
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Sep 2015 10:11:59 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zc9gz-0003mc-D3
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Sep 2015 10:11:59 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUR012WULNGUZ10@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Sep 2015 19:11:50 +0900 (KST)
In-reply-to: <20150915165215.GA82346@jaegeuk-mac02.mot.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, September 16, 2015 12:52 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: stable@vger.kernel.org
> Subject: Re: [f2fs-dev] [PATCH v3] f2fs crypto: allocate buffer for decrypting filename
> 
> Change log from v1:
>   o fix wrong pointer assignment
> 
> Chang log from v2:
>   o add one more missing call path: f2fs_encrypted_follow_link
> 
> >From 84574dd5c3e8ed9ca9fdfcbd251b354cdbc5ecab Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Thu, 3 Sep 2015 13:38:23 -0700
> Subject: [PATCH 1/3] f2fs crypto: allocate buffer for decrypting filename
> 
> We got dentry pages from high_mem, and its address space directly goes into the
> decryption path via f2fs_fname_disk_to_usr.
> But, sg_init_one assumes the address is not from high_mem, so we can get this
> panic since it doesn't call kmap_high but kunmap_high is triggered at the end.
> 
> kernel BUG at ../../../../../../kernel/mm/highmem.c:290!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
> ...
>  (kunmap_high+0xb0/0xb8) from [<c0114534>] (__kunmap_atomic+0xa0/0xa4)
>  (__kunmap_atomic+0xa0/0xa4) from [<c035f028>] (blkcipher_walk_done+0x128/0x1ec)
>  (blkcipher_walk_done+0x128/0x1ec) from [<c0366c24>] (crypto_cbc_decrypt+0xc0/0x170)
>  (crypto_cbc_decrypt+0xc0/0x170) from [<c0367148>] (crypto_cts_decrypt+0xc0/0x114)
>  (crypto_cts_decrypt+0xc0/0x114) from [<c035ea98>] (async_decrypt+0x40/0x48)
>  (async_decrypt+0x40/0x48) from [<c032ca34>] (f2fs_fname_disk_to_usr+0x124/0x304)
>  (f2fs_fname_disk_to_usr+0x124/0x304) from [<c03056fc>] (f2fs_fill_dentries+0xac/0x188)
>  (f2fs_fill_dentries+0xac/0x188) from [<c03059c8>] (f2fs_readdir+0x1f0/0x300)
>  (f2fs_readdir+0x1f0/0x300) from [<c0218054>] (vfs_readdir+0x90/0xb4)
>  (vfs_readdir+0x90/0xb4) from [<c0218418>] (SyS_getdents64+0x64/0xcc)
>  (SyS_getdents64+0x64/0xcc) from [<c0105ba0>] (ret_fast_syscall+0x0/0x30)
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/dir.c   | 14 +++++++++++---
>  fs/f2fs/namei.c |  8 +++++++-
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 8f15fc1..cce512c 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -773,6 +773,7 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr
> *d,
>  	unsigned int bit_pos;
>  	struct f2fs_dir_entry *de = NULL;
>  	struct f2fs_str de_name = FSTR_INIT(NULL, 0);
> +	char *name = NULL;
> 
>  	bit_pos = ((unsigned long)ctx->pos % d->max);
> 
> @@ -788,8 +789,10 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr
> *d,
>  			d_type = DT_UNKNOWN;
> 
>  		/* encrypted case */
> -		de_name.name = d->filename[bit_pos];
>  		de_name.len = le16_to_cpu(de->name_len);
> +		name = kmalloc(de_name.len, GFP_NOFS);

How do you think of handling the failure of kmalloc with GFP_NOFS?

> +		memcpy(name, d->filename[bit_pos], de_name.len);

If current inode is not encrypted, our kmalloc & memcpy will be overhead,
How about changing our codes to avoid that?

Thanks,



------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
