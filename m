From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH] f2fs-tools: introduce tune.f2fs
Date: Fri, 27 Apr 2018 10:32:11 +0800
Message-ID: <11707e83-2478-f6d6-bc7e-c19cd44a55c2@huawei.com>
References: <13c34f59-6f6a-8252-0a9f-effccbcd6db0@huawei.com>
 <20180423073202.150763-1-zhengjunling@huawei.com>
 <40f78225-7a7d-e761-2e84-f357b7fecf2e@huawei.com>
 <20180426161315.GK68594@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fBtBW-0007AM-Am
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Apr 2018 02:32:30 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fBtBU-00BCuU-7e
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Apr 2018 02:32:30 +0000
In-Reply-To: <20180426161315.GK68594@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Junling Zheng <zhengjunling@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/4/27 0:13, Jaegeuk Kim wrote:
> On 04/26, Junling Zheng wrote:
>> Ping...
>>
>> On 2018/4/23 15:32, Junling Zheng wrote:
>>> Introduce tune.f2fs tool to change the f2fs parameters.
>>> Currently this tool only supports adding or removing encrypt
>>> feature bit in superblock.
> 
> What is the purpose of this empty tune.f2fs? How can we say we have this
> tool to users? You have to design what kind of things to support first.

I checked very initial tune2fs.c, it only supports very few parameters tuning
functionality, but, can not say that is a bad start to introduce the misc tool.

+       fprintf (stderr, "Usage: %s [-c max-mounts-count] [-e errors-behavior] "
+                "[-i interval[d|m]]\n"
+                "\t[-l] [-m reserved-blocks-percent] device\n", program_name);

Maybe tuning 1. extension list, 2. multi device name later? just guess.

Using fsck.f2fs to tune parameter, IMO, maybe a little confuse for user to
understand the tool's functionality.

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
