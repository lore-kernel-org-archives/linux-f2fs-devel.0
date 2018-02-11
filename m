From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Cold log explanation
Date: Sun, 11 Feb 2018 11:16:06 +0800
Message-ID: <25fc9bc6-d022-97ac-1cbc-c4015ae1373e@huawei.com>
References: <20180210154519.GA11491@lazy.lzy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eki7P-0006EP-NO
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Feb 2018 03:15:55 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eki7N-0002JV-JM
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Feb 2018 03:15:55 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 85E201B6C1A29
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 11 Feb 2018 11:15:34 +0800 (CST)
In-Reply-To: <20180210154519.GA11491@lazy.lzy>
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
To: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>, linux-f2fs-devel@lists.sourceforge.net

On 2018/2/10 23:45, Piergiorgio Sartor wrote:
> Hi all,
> 
> I noticed that "mkfs.f2fs" has an option, "-e",
> to store certain files into the "cold log".
> 
> First, basic question, what is the "cold log" or,
> better, what is the differnce between the "normal"
> ("warm", I guess) log and this one.

Could you check this paper of fast15? :)

https://www.usenix.org/conference/fast15/technical-sessions/presentation/lee

> 
> Second, it is possible to disable this list *after*
> filesystem creation?
> Maybe even with it mounted?

I'm working on this feature via sysfs, will send it out soon.

Thanks,

> 
> Thanks a lot in advance,
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
