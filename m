From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: Re: Hung task when executing generic/256 test
Date: Fri, 18 May 2018 10:56:05 +0530
Message-ID: <7833966.PD9W5pZvT2@localhost.localdomain>
References: <2479794.CdILPghxpW@localhost.localdomain>
 <20180518005103.GA33876@jaegeuk-macbookpro.roam.corp.google.com>
 <82af3e21-4e57-07e1-28c5-fdf034dc3a27@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1fJXtE-0001Xl-EX
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 18 May 2018 05:25:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fJXtC-00BBVA-Rl
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 18 May 2018 05:25:16 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4I5P4rQ023457
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 18 May 2018 01:25:04 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j1kfm28nu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 18 May 2018 01:25:03 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Fri, 18 May 2018 06:24:26 +0100
In-Reply-To: <82af3e21-4e57-07e1-28c5-fdf034dc3a27@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On Friday, May 18, 2018 6:44:43 AM IST Chao Yu wrote:
> On 2018/5/18 8:51, Jaegeuk Kim wrote:
> > On 05/08, Chandan Rajendra wrote:
> >> Hi,
> >>
> >> The following "Hung task" information is seen when executing generic/256 test
> >> on next-20180503.
> > 
> > Hi Chandan,
> > 
> > Is this still happening? Since I don't see this in my local test.
> 
> With last dev-test codes, I can't reproduce this bug..
> 
> Could you have a try with codes in dev-test branch of Jaegeuk's tree?

I am unable to recreate the problem With the sources at dev-test branch.

-- 
chandan


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
