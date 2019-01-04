From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: don't access node/meta inode mapping
 after iput
Date: Fri, 4 Jan 2019 17:32:22 +0800
Message-ID: <1f89b87c-dd69-66c0-4d0b-ff9f5215c588@huawei.com>
References: <20190104042025.31982-1-jaegeuk@kernel.org>
 <20190104042025.31982-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104042025.31982-2-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/1/4 12:20, Jaegeuk Kim wrote:
> This fixes wrong access of address spaces of node and meta inodes after iput.
> 
> Fixes: 60aa4d5536ab ("f2fs: fix use-after-free issue when accessing sbi->stat_info")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
