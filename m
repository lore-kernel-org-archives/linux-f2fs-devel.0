From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic: test i_mode recovery after power
 failure
Date: Fri, 8 Mar 2019 07:22:14 +1100
Message-ID: <20190307202214.GH26298@dastard>
References: <20190305114744.129633-1-yuchao0@huawei.com>
 <20190305205344.GC26298@dastard>
 <0f1af38b-5dbf-a56a-c0c1-72cf9fafb515@huawei.com>
 <20190306050049.GA23020@dastard>
 <CAOQ4uxigMqW8cQO0Veo_JXsVta6WvKv0QHAQ1KcVOwqY1CCL+A@mail.gmail.com>
 <20190306221202.GG26298@dastard>
 <CAOQ4uxjDCcgX7B8vC8Dfd2Y20PkikdkFOz-Xttu5oG8nq3AYPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <david@fromorbit.com>) id 1h1zX8-0006MI-GW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Mar 2019 20:22:26 +0000
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1h1zX6-00GieE-PM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Mar 2019 20:22:26 +0000
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjDCcgX7B8vC8Dfd2Y20PkikdkFOz-Xttu5oG8nq3AYPw@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Amir Goldstein <amir73il@gmail.com>
Cc: Filipe Manana <fdmanana@gmail.com>, fstests <fstests@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Eryu Guan <guaneryu@gmail.com>, Jayashree Mohan <jaya@cs.utexas.edu>

On Thu, Mar 07, 2019 at 09:12:06AM +0200, Amir Goldstein wrote:
> On Thu, Mar 7, 2019 at 12:12 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Mar 06, 2019 at 09:44:54AM +0200, Amir Goldstein wrote:
> > > > > >
> > > > > > Oh, wait, we *already have that infrastructure*: src/fsync-tester.c
> > > > > > and generic/311.
> > > > > >
> > >
> > > Right now 311 is not "quick".
> > > That means adding quick tests to it without breaking it up or declaring it quick
> > > is not a good idea.
> >
> > Why would we need to change the group? Indeed, I almost never use
> > the "quick" group anymore because it doesn't mean "quickly run a
> > smoke test" anymore. It now just means "test doesn't take a long
> > time" but that still adds up to 30-60 minutes of runtime (depending
> > on storage) because of the hundreds of tests in the quick group.
> >
> > If you are testing crash recovery changes, then you are likely
> > running the "log" group to execute all the crash recovery tests,
> > maybe the "metadata" group, and maybe the "shutdown" group.
> >
> > So I don't think the this test not being in the "quick" group is
> > relevant at all.
> >
> 
> OK. Just pointing your attention to the fact that the test generic/520
> is a result of public discussion of how crash consistency tests should
> be aggregated into xfstests tests.

That was about how the crashmonkey tests would be integrated, not
generic fsync tests should be integrated.  There lots of
auto-generated crashmonkey tests them and they were proposing a
single fs test per single fsync test. We ended up settling  on
"aggregating into related groups" and generic/520 only covers one
specific group - only about 5 test cases of the many, many
crashmonkey test cases that were proposed. Which leaves me to
ponder: what happened to the rest of the Crashmonkey test cases that
were supposed to follow on from generic/520?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
