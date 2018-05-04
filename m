From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH] f2fs-tools: introduce tune.f2fs
Date: Fri, 4 May 2018 12:06:07 -0700
Message-ID: <20180504190607.GE27993@jaegeuk-macbookpro.roam.corp.google.com>
References: <13c34f59-6f6a-8252-0a9f-effccbcd6db0@huawei.com>
 <20180423073202.150763-1-zhengjunling@huawei.com>
 <40f78225-7a7d-e761-2e84-f357b7fecf2e@huawei.com>
 <20180426161315.GK68594@jaegeuk-macbookpro.roam.corp.google.com>
 <11707e83-2478-f6d6-bc7e-c19cd44a55c2@huawei.com>
 <20180428024946.GE10595@jaegeuk-macbookpro.roam.corp.google.com>
 <367bf3b0-461d-eada-89ff-817cfb3c7fd3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fEg27-0004YL-8o
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 May 2018 19:06:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fEg26-008tXN-0q
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 May 2018 19:06:19 +0000
Content-Disposition: inline
In-Reply-To: <367bf3b0-461d-eada-89ff-817cfb3c7fd3@huawei.com>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

On 05/02, Chao Yu wrote:
> On 2018/4/28 10:49, Jaegeuk Kim wrote:
> > On 04/27, Chao Yu wrote:
> >> On 2018/4/27 0:13, Jaegeuk Kim wrote:
> >>> On 04/26, Junling Zheng wrote:
> >>>> Ping...
> >>>>
> >>>> On 2018/4/23 15:32, Junling Zheng wrote:
> >>>>> Introduce tune.f2fs tool to change the f2fs parameters.
> >>>>> Currently this tool only supports adding or removing encrypt
> >>>>> feature bit in superblock.
> >>>
> >>> What is the purpose of this empty tune.f2fs? How can we say we have this
> >>> tool to users? You have to design what kind of things to support first.
> >>
> >> I checked very initial tune2fs.c, it only supports very few parameters tuning
> >> functionality, but, can not say that is a bad start to introduce the misc tool.
> >>
> >> +       fprintf (stderr, "Usage: %s [-c max-mounts-count] [-e errors-behavior] "
> >> +                "[-i interval[d|m]]\n"
> >> +                "\t[-l] [-m reserved-blocks-percent] device\n", program_name);
> > 
> > I don't think We have to follow that.
> > 
> >>
> >> Maybe tuning 1. extension list, 2. multi device name later? just guess.
> > 
> > First of all, does it make sense to unset feature bits? I don't think so.
> 
> Some features can be turned off in a initial image? like encrypted, extra_attr,
> checksum...?

Any reason to do thtat? And, we need to find all the files whether there is
any encrypted file.

> 
> > 
> > Agreed to your suggestion where:
> > 1. feature set
> >   - enable system quota
> > 2. extension list
> > 3. multi device name -- which may be really big trial
> 
> So what's our plan now? fill those features into fsck when we need them?

No. If you want to add tune.f2fs, I'd like to see some demand, or very useful
features like this. I just want to avoid introducing an (almost) empty tool.

Thanks,

> 
> Thanks,
> 
> > 
> >>
> >> Using fsck.f2fs to tune parameter, IMO, maybe a little confuse for user to
> >> understand the tool's functionality.
> >>
> >> Thanks,
> > 
> > .
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
