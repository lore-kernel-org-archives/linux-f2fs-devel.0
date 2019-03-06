From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] generic: test i_mode recovery after power
 failure
Date: Thu, 7 Mar 2019 09:12:02 +1100
Message-ID: <20190306221202.GG26298@dastard>
References: <20190305114744.129633-1-yuchao0@huawei.com>
 <20190305205344.GC26298@dastard>
 <0f1af38b-5dbf-a56a-c0c1-72cf9fafb515@huawei.com>
 <20190306050049.GA23020@dastard>
 <CAOQ4uxigMqW8cQO0Veo_JXsVta6WvKv0QHAQ1KcVOwqY1CCL+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <david@fromorbit.com>) id 1h1elr-0000NQ-ES
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Mar 2019 22:12:15 +0000
Received: from ipmail01.adl6.internode.on.net ([150.101.137.136])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1h1elp-00EyE3-DI
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Mar 2019 22:12:15 +0000
Content-Disposition: inline
In-Reply-To: <CAOQ4uxigMqW8cQO0Veo_JXsVta6WvKv0QHAQ1KcVOwqY1CCL+A@mail.gmail.com>
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
Cc: Filipe Manana <fdmanana@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>

On Wed, Mar 06, 2019 at 09:44:54AM +0200, Amir Goldstein wrote:
> > > >
> > > > Oh, wait, we *already have that infrastructure*: src/fsync-tester.c
> > > > and generic/311.
> > > >
> 
> Right now 311 is not "quick".
> That means adding quick tests to it without breaking it up or declaring it quick
> is not a good idea.

Why would we need to change the group? Indeed, I almost never use
the "quick" group anymore because it doesn't mean "quickly run a
smoke test" anymore. It now just means "test doesn't take a long
time" but that still adds up to 30-60 minutes of runtime (depending
on storage) because of the hundreds of tests in the quick group.

If you are testing crash recovery changes, then you are likely
running the "log" group to execute all the crash recovery tests,
maybe the "metadata" group, and maybe the "shutdown" group.

So I don't think the this test not being in the "quick" group is
relevant at all.

> > > https://patchwork.kernel.org/patch/10042149/
> > >
> > > Or to avoid redundant copied code from generic/311 in each fsync related
> > > patch, do I need just add my case into fsync_tester.c? and before
> > > announcement of fstests master branch, we can add one testcase into
> > > generic/ directory, in that testcase we gather/test all new added cases in
> > > fsync_tester.c recently.
> >
> > Gathering them all into fsync-tester is what I'm suggesting should
> > be done....
> >
> 
> We could introduce the concept of test cases into the test infrastructure.
> For example:
> 
> --- a/tests/generic/311
> +++ b/tests/generic/311
> @@ -90,7 +90,7 @@ _mount_flakey
>  buffered=0
>  direct=1
> 
> -for i in $(seq 1 20); do
> +for i in $(seq ${TEST_CASE_START:-1} ${TEST_CASE_END:-20}); do
>         lockfs=1
>         SEED=$i
>         echo "Running test $i buffered, normal suspend"
> ---
> 
> Adding a new test cases (beyond changing fsync_tester.c)
> requires:
> - Creating symlink tests/generic/311:21..24 -> 311
> - Writing golden output tests/generic/311:21..24.out

Why create complex new infrastructure for something we already have
mechanisms to do?

i.e. move the common code into common/<file>, include it in the new
test, and call:

_<common_test_func> 21 24

To constrain it to just the cases that this test runs.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
