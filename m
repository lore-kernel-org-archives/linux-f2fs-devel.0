From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: let fstrim issue discard commands
 in lower priority
Date: Sat, 26 May 2018 08:45:34 +0800
Message-ID: <9a7e1ff0-f4b1-52b2-9849-6d2ec0a9307d@huawei.com>
References: <20180525051031.36443-1-jaegeuk@kernel.org>
 <20180525194916.GA52740@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fMNL4-0005Cr-8p
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 26 May 2018 00:45:42 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fMNL2-003vhX-BQ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 26 May 2018 00:45:42 +0000
In-Reply-To: <20180525194916.GA52740@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/5/26 3:49, Jaegeuk Kim wrote:
> The fstrim gathers huge number of large discard commands, and tries to issue
> without IO awareness, which results in long user-perceive IO latencies on
> READ, WRITE, and FLUSH in UFS. We've observed some of commands take several
> seconds due to long discard latency.
> 
> This patch limits the maximum size to 2MB per candidate, and check IO congestion
> when issuing them to disk.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

It looks good to me. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
