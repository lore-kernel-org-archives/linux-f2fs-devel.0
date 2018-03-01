From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: don't put dentry page in pagecache into highmem
Date: Thu, 1 Mar 2018 09:20:56 +0800
Message-ID: <dcb20f79-0107-661c-0dec-9251f799ae44@huawei.com>
References: <1519821112-137593-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519821112-137593-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/2/28 20:31, Yunlong Song wrote:
> Previous dentry page uses highmem, which will cause panic in platforms
> using highmem (such as arm), since the address space of dentry pages
> from highmem directly goes into the decryption path via the function
> fscrypt_fname_disk_to_usr. But sg_init_one assumes the address is not
> from highmem, and then cause panic since it doesn't call kmap_high but
> kunmap_high is triggered at the end. To fix this problem in a simple
> way, this patch avoids to put dentry page in pagecache into highmem.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
