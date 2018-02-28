From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: do gc in greedy mode for whole range if gc_urgent
 mode is set
Date: Wed, 28 Feb 2018 17:32:36 +0800
Message-ID: <e208bc13-66b4-4783-2ac1-93123021fed7@huawei.com>
References: <20180228050826.83137-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180228050826.83137-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/2/28 13:08, Jaegeuk Kim wrote:
> Otherwise, f2fs conducts GC on 8GB range only based on slow cost-benefit.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
