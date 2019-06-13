From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix is_idle() check for discard type
Date: Thu, 13 Jun 2019 14:52:43 +0800
Message-ID: <d3b4b733-78ab-29bb-9441-c6e4e7efaea9@huawei.com>
References: <1559813893-23452-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hbJbT-0001b0-0o
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 06:52:55 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hbJbR-00BBf7-71
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 06:52:55 +0000
In-Reply-To: <1559813893-23452-1-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

On 2019/6/6 17:38, Sahitya Tummala wrote:
> The discard thread should issue upto dpolicy->max_requests at once
> and wait for all those discard requests at once it reaches
> dpolicy->max_requests. It should then sleep for dpolicy->min_interval
> timeout before issuing the next batch of discard requests. But in the
> current code of is_idle(), it checks for dcc_info->queued_discard and
> aborts issuing the discard batch of max_requests. This
> dcc_info->queued_discard will be true always once one discard command
> is issued.
> 
> It is thus resulting into this type of discard request pattern -
> 
> - Issue discard request#1
> - is_idle() returns false, discard thread waits for request#1 and then
>   sleeps for min_interval 50ms.
> - Issue discard request#2
> - is_idle() returns false, discard thread waits for request#2 and then
>   sleeps for min_interval 50ms.
> - and so on for all other discard requests, assuming f2fs is idle w.r.t
>   other conditions.
> 
> With this fix, the pattern will look like this -
> 
> - Issue discard request#1
> - Issue discard request#2
>   and so on upto max_requests of 8
> - Issue discard request#8
> - wait for min_interval 50ms.
> 

Fixes: fef4129ec2e6 ("f2fs: fix to be aware discard/preflush/dio command in
is_idle()")

> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Ah, thanks for fixing this bug.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
