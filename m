From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: allocate buffer for decrypting filename to avoid
 panic
Date: Wed, 28 Feb 2018 10:49:12 +0800
Message-ID: <786c9ff4-2214-b980-8a94-184345cee3b8@huawei.com>
References: <1519463698-60555-1-git-send-email-yunlong.song@huawei.com>
 <1519784380-83138-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519784380-83138-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/2/28 10:19, Yunlong Song wrote:
> In some platforms (such as arm), high memory is used, then the
> decrypting filename will cause panic, the reason see commit
> 569cf1876a32e574ba8a7fb825cd91bafd003882 ("f2fs crypto: allocate buffer
> for decrypting filename"):
> 
>  We got dentry pages from high_mem, and its address space directly goes into the
>  decryption path via f2fs_fname_disk_to_usr.
>  But, sg_init_one assumes the address is not from high_mem, so we can get this
>  panic since it doesn't call kmap_high but kunmap_high is triggered at the end.
> 
>  kernel BUG at ../../../../../../kernel/mm/highmem.c:290!
>  Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>  ...
>   (kunmap_high+0xb0/0xb8) from [<c0114534>] (__kunmap_atomic+0xa0/0xa4)
>   (__kunmap_atomic+0xa0/0xa4) from [<c035f028>] (blkcipher_walk_done+0x128/0x1ec)
>   (blkcipher_walk_done+0x128/0x1ec) from [<c0366c24>] (crypto_cbc_decrypt+0xc0/0x170)
>   (crypto_cbc_decrypt+0xc0/0x170) from [<c0367148>] (crypto_cts_decrypt+0xc0/0x114)
>   (crypto_cts_decrypt+0xc0/0x114) from [<c035ea98>] (async_decrypt+0x40/0x48)
>   (async_decrypt+0x40/0x48) from [<c032ca34>] (f2fs_fname_disk_to_usr+0x124/0x304)
>   (f2fs_fname_disk_to_usr+0x124/0x304) from [<c03056fc>] (f2fs_fill_dentries+0xac/0x188)
>   (f2fs_fill_dentries+0xac/0x188) from [<c03059c8>] (f2fs_readdir+0x1f0/0x300)
>   (f2fs_readdir+0x1f0/0x300) from [<c0218054>] (vfs_readdir+0x90/0xb4)
>   (vfs_readdir+0x90/0xb4) from [<c0218418>] (SyS_getdents64+0x64/0xcc)
>   (SyS_getdents64+0x64/0xcc) from [<c0105ba0>] (ret_fast_syscall+0x0/0x30)
> 
> Howerver, later patches:
> commit e06f86e61d7a67fe6e826010f57aa39c674f4b1b ("f2fs crypto: avoid
> unneeded memory allocation in ->readdir")
> 
> reverts the codes, which causes panic again in arm, so let's add part of
> the old patch again for dentry page.
> 

Fixes: e06f86e61d7a ("f2fs crypto: avoid unneeded memory allocation in ->readdir")

> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Looks good to me, you can add:

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Minor, we can just use 'git revert' to generate patch, so that commit title can
notice the patch are reverting buggy commit.

Thanks,
