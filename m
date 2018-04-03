From: Tejun Heo <tj@kernel.org>
Subject: Re: [GIT PULL] f2fs update for 4.16-rc1
Date: Tue, 3 Apr 2018 07:20:29 -0700
Message-ID: <20180403142029.GM388343@devbig577.frc2.facebook.com>
References: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
 <20180131095446.443670dc@canb.auug.org.au>
 <20180131002535.GD65489@jaegeuk-macbookpro.roam.corp.google.com>
 <20180201092551.759f32be@canb.auug.org.au>
 <20180314101704.51aaae7f@canb.auug.org.au>
 <20180403122919.3c503f74@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <htejun@gmail.com>) id 1f3Mnj-0000ac-OG
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Apr 2018 14:20:43 +0000
Received: from mail-yb0-f176.google.com ([209.85.213.176])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1f3Mne-001YoA-7l
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 03 Apr 2018 14:20:43 +0000
Received: by mail-yb0-f176.google.com with SMTP id e3-v6so6240486ybk.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 03 Apr 2018 07:20:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20180403122919.3c503f74@canb.auug.org.au>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Yufen Yu <yuyufen@huawei.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Chris Mason <clm@fb.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hello, Stephen.

On Tue, Apr 03, 2018 at 12:29:19PM +1000, Stephen Rothwell wrote:
> > I am still applying this to the merge of the btrfs tree every day ...
> > 
> > Commit
> >   578c647879f7 ("f2fs: implement cgroup writeback support")
> > was merged into Linus' tree on Jan 31.
> > 
> > Here is the actual merge fix patch:

Yeah, the merge fix looks correct to me.  Depending on the merge
order, it can go either after the btrfs merge or the f2fs merge, I
guess.  Stephen, beyond appyling the merge fix afterwards, is there
somethine else you are concerned about?

Thanks.

-- 
tejun

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
