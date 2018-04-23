From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: check cap_resource only for data blocks
Date: Mon, 23 Apr 2018 16:23:18 +0800
Message-ID: <ab54e37b-5b9d-b420-89c2-edfcbd9f4558@huawei.com>
References: <20180421065308.84211-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180421065308.84211-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/4/21 14:53, Jaegeuk Kim wrote:
> This patch changes the rule to check cap_resource for data blocks, not inode
> or node blocks in order to avoid selinux denial.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
