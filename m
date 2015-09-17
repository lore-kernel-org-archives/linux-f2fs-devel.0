From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH v4] f2fs crypto: allocate buffer for decrypting
 filename
Date: Thu, 17 Sep 2015 20:24:27 +0800
Message-ID: <009c01d0f143$eb324ef0$c196ecd0$@samsung.com>
References: <1441936062-69511-1-git-send-email-jaegeuk@kernel.org>
 <20150911224550.GA73045@jaegeuk-mac02.mot.com>
 <20150915165215.GA82346@jaegeuk-mac02.mot.com>
 <000901d0f068$1a1bd100$4e537300$@samsung.com>
 <20150916175715.GA99097@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-reply-to: <20150916175715.GA99097@jaegeuk-mac02.mot.com>
Content-language: zh-cn
Sender: stable-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, September 17, 2015 1:57 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net; stable@vger.kernel.org
> Subject: Re: [f2fs-dev] [PATCH v4] f2fs crypto: allocate buffer for decrypting filename
> 
> Thanks Chao,
> 
> Change log from v3:
>   o enhance the code with proper error handling
> 
> Change log from v1:
>   o fix wrong pointer assignment
> 
> Chang log from v2:
>   o add one more missing call path: f2fs_encrypted_follow_link
> 
> From efdbbbb4c9bb6519e3c10ec5081a2dcdbaca81d2 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Thu, 3 Sep 2015 13:38:23 -0700
> Subject: [PATCH] f2fs crypto: allocate buffer for decrypting filename
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

Reviewed-by: Chao Yu <chao2.yu@samsung.com>
