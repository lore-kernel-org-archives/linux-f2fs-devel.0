From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix to return 0 if err == -ENOENT in f2fs_readdir
Date: Wed, 27 Apr 2016 21:25:09 +0800
Message-ID: <5720BDB5.9000106@kernel.org>
References: <1461760357-13882-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461760357-13882-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, cm224.lee@samsung.com, yuchao0@huawei.com, sylinux@163.com
Cc: bintian.wang@huawei.com, houpengyang@huawei.com, heyunlei@huawei.com, liushuoran@huawei.com, shiguojun@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/4/27 20:32, Yunlong Song wrote:
> Commit 57b62d29ad5b384775974973087d47755a8c6fcc ("f2fs: fix to report
> error in f2fs_readdir") causes f2fs_readdir to return -ENOENT when
> get_lock_data_page returns -ENOENT. However, the original logic is to
> continue when get_lock_data_page returns -ENOENT, but it forgets to
> reset err to 0.
> 
> This will cause getdents64 incorretly return -ENOENT when lastdirent is
> NULL in getdents64. This will lead to a wrong return value for syscall
> caller.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
