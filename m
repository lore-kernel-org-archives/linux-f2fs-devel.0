From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: issue discard commands proactively in
 high fs utilization
Date: Wed, 30 May 2018 22:29:58 +0800
Message-ID: <c179f3d9-1742-8f98-2c68-6c7d19c3cda4@kernel.org>
References: <20180529205048.39694-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529205048.39694-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/5/30 4:50, Jaegeuk Kim wrote:
> In the high utilization like over 80%, we don't expect huge # of large discard
> commands, but do many small pending discards which affects FTL GCs a lot.
> Let's issue them in that case.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
