From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] f2fs: introduce gc_urgent mode for background GC
Date: Thu, 10 Aug 2017 18:44:52 +0800
Message-ID: <7672f2f0-3c7c-71b2-f8a0-decad62b06f3@huawei.com>
References: <20170808014222.31097-1-jaegeuk@kernel.org>
 <20170808014222.31097-2-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170808014222.31097-2-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/8/8 9:42, Jaegeuk Kim wrote:
> This patch adds a sysfs entry to control urgent mode for background GC.
> If this is set, background GC thread conducts GC with gc_urgent_sleep_time
> all the time.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>
