From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: SMR drive test 2; 128GB partition;
 no obvious corruption, much more sane behaviour, weird
 overprovisioning
Date: Fri, 25 Sep 2015 10:45:46 -0700
Message-ID: <20150925174546.GA6269@jaegeuk-mac02.mot.com>
References: <20150921081748.GA5637@schmorp.de>
	<20150921081937.GA5718@schmorp.de>
	<20150921095806.GA6809@schmorp.de>
	<20150923011239.GA32520@jaegeuk-mac02.mot.com>
	<20150923041523.GB4946@schmorp.de>
	<20150923060037.GA6667@schmorp.de>
	<20150923220823.GE36564@jaegeuk-mac02.mot.com>
	<20150923233937.GE3463@schmorp.de>
	<20150924172749.GB40291@jaegeuk-mac02>
	<20150925054225.GB486@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZfX4G-0004eF-Nh
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 17:45:56 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZfX4F-0006kf-GK for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Sep 2015 17:45:56 +0000
Content-Disposition: inline
In-Reply-To: <20150925054225.GB486@schmorp.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Marc Lehmann <schmorp@schmorp.de>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Fri, Sep 25, 2015 at 07:42:25AM +0200, Marc Lehmann wrote:
> On Thu, Sep 24, 2015 at 10:27:49AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > > In the end, I might settle with -s64, and currently do tests with -s90.
> > 
> > Got it. But why -s90? :)
> 
> He :) It's a nothing-special number between 64 and 128, that's all.

Oh, then, I don't think that is a good magic number.
It seems that you decided to use -s64, so it'd better to keep it to address
any perf results.

> > I just pushed the patches to master branch in f2fs-tools.git.
> > Could you pull them and check them?
> 
> Got them, last patch was the "check sit types" change.
> 
> > I added one more patch to avoid harmless sit_type fixes previously you reported.
> > 
> > And, for the 8TB case, let me check again. It seems that we need to handle under
> > 1% overprovision ratio. (e.g., 0.5%)
> 
> That might make me potentially very happy. But my main concern at the
> moment is stability - even when you have a backup, restoring 8TB will take
> days, and backups are never uptodate.
> 
> It would be nice to be able to control it more from the user side though.
> 
> For example, I have not yet reached 0.0% free with f2fs. That's fine, I don't
> plan9 to, but I need to know at which percentage should I stop, which is
> something I can only really find out with experiments.
> 
> And just filling these 8TB disks takes days, so the question is, can I
> simulate near-full behaviour with smaller partitions.

Why not? :)
I think the behavior should be same. And, it'd good to set small sections
in order to see it more clearly.

Anyway, I wrote a patch to consider under 1% for large partitions.

 section  ovp ratio  ovp size

For 8TB,
 -s1    : 0.07%   -> 10GB
 -s32   : 0.39%   -> 65GB
 -s64   : 0.55%   -> 92GB
 -s128  : 0.78%   -> 132GB

For 128GB,
 -s1    : 0.55%   -> 1.4GB
 -s32   : 3.14%   -> 8GB
 -s64   : 4.45%   -> 12GB
 -s128  : 6.32%   -> 17GB

Let me test this patch for a while, and then push into our git.

Thanks,

>From 2cdb04b52f202e931e370564396366d44bd4d1e2 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 25 Sep 2015 09:31:04 -0700
Subject: [PATCH] mkfs.f2fs: support <1% overprovision ratio

Big partition size needs uner 1% overprovision space to acquire more space.

    section  ovp ratio  ovp size
For 8TB,
    -s1    : 0.07%     -> 10GB
    -s32   : 0.39%     -> 65GB
    -s64   : 0.55%     -> 92GB
    -s128  : 0.78%     -> 132GB

For 128GB,
    -s1    : 0.55%     -> 1.4GB
    -s32   : 3.14%     -> 8GB
    -s64   : 4.45%     -> 12GB
    -s128  : 6.32%     -> 17GB

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h       |  2 +-
 mkfs/f2fs_format.c      | 12 ++++++------
 mkfs/f2fs_format_main.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 38a774c..359deec 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -225,7 +225,7 @@ enum f2fs_config_func {
 struct f2fs_configuration {
 	u_int32_t sector_size;
 	u_int32_t reserved_segments;
-	u_int32_t overprovision;
+	double overprovision;
 	u_int32_t cur_seg[6];
 	u_int32_t segs_per_sec;
 	u_int32_t secs_per_zone;
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 2d4ab09..176bdea 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -155,19 +155,19 @@ static void configure_extension_list(void)
 	free(config.extension_list);
 }
 
-static u_int32_t get_best_overprovision(void)
+static double get_best_overprovision(void)
 {
-	u_int32_t reserved, ovp, candidate, end, diff, space;
-	u_int32_t max_ovp = 0, max_space = 0;
+	double reserved, ovp, candidate, end, diff, space;
+	double max_ovp = 0, max_space = 0;
 
 	if (get_sb(segment_count_main) < 256) {
 		candidate = 10;
 		end = 95;
 		diff = 5;
 	} else {
-		candidate = 1;
+		candidate = 0.01;
 		end = 10;
-		diff = 1;
+		diff = 0.01;
 	}
 
 	for (; candidate <= end; candidate += diff) {
@@ -533,7 +533,7 @@ static int f2fs_write_check_point_pack(void)
 	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
 			get_cp(rsvd_segment_count));
 
-	MSG(0, "Info: Overprovision ratio = %u%%\n", config.overprovision);
+	MSG(0, "Info: Overprovision ratio = %.3lf%%\n", config.overprovision);
 	MSG(0, "Info: Overprovision segments = %u (GC reserved = %u)\n",
 					get_cp(overprov_segment_count),
 					config.reserved_segments);
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index fc612d8..2ea809c 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -99,7 +99,7 @@ static void f2fs_parse_options(int argc, char *argv[])
 			config.vol_label = optarg;
 			break;
 		case 'o':
-			config.overprovision = atoi(optarg);
+			config.overprovision = atof(optarg);
 			break;
 		case 'O':
 			parse_feature(strdup(optarg));
-- 
2.1.1


------------------------------------------------------------------------------
