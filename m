From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: update i_size after DIO completion
Date: Wed, 26 Sep 2018 13:41:11 +0800
Message-ID: <a8591335-78f7-949e-9cf5-b752660b26f4@huawei.com>
References: <20180920215108.38802-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920215108.38802-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/21 5:51, Jaegeuk Kim wrote:
> This is related to
> ee70daaba82d ("xfs: update i_size after unwritten conversion in dio completion")
> 
> If we update i_size during dio_write, dio_read can read out stale data, which
> breaks xfstests/465.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
