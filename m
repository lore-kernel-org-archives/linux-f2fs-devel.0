From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: no need to take page lock in readdir
Date: Wed, 27 Feb 2019 20:44:29 +0800
Message-ID: <ffaf00f3-7b17-e6e4-81b5-ede59102843b@huawei.com>
References: <20190221045735.45419-1-gaoxiang25@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221045735.45419-1-gaoxiang25@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Gao Xiang <gaoxiang25@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/2/21 12:57, Gao Xiang wrote:
> VFS will take inode_lock for readdir, therefore no need to
> take page lock in readdir at all just as the majority of
> other generic filesystems.
> 
> This patch improves concurrency since .iterate_shared
> was introduced to VFS years ago.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
