From: Namjae Jeon <linkinjeon@gmail.com>
Subject: [f2fs-dev] [PATCH 2/4] f2fs: reorganise the function
	get_victim_by_default
Date: Sat,  8 Jun 2013 21:25:16 +0900
Message-ID: <1370694316-2772-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linkinjeon@gmail.com>) id 1UlID3-0007Yd-HH
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Jun 2013 12:25:29 +0000
Received: from mail-pd0-f174.google.com ([209.85.192.174])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UlID2-0007ZG-ND
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Jun 2013 12:25:29 +0000
Received: by mail-pd0-f174.google.com with SMTP id 10so4844238pdc.19
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 08 Jun 2013 05:25:22 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: Namjae Jeon <linkinjeon@gmail.com>, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Namjae Jeon <namjae.jeon@samsung.com>

Fix the function get_victim_by_default, where it checks
for the condition  that p.min_segno != NULL_SEGNO as
shown:

if (p.min_segno != NULL_SEGNO)
           goto got_it;

and if above condition is true then

got_it:
        if (p.min_segno != NULL_SEGNO) {

So this condition is being checked twice. Hence move the goto
statement after the if condition so that duplication of condition
check is avoided.

Also this function makes a call to get_max_cost() to compute
the max cost based on the f2fs_sbi_info and victim policy. Since
get_max_cost depends on on three parameters of victim_sel_policy
=> alloc_mode, gc_mode & ofs_unit, once this victim policy is
initialised, these value will not change till the execution
time of get_victim_by_default() & also f2fs_sbi_info structure
parameters will not change.

Hence making calls to get_max_cost() in while loop does not seems to
be a good point. Instead we can call it once in begining and store
the results in local variable, which later can serve our purpose
for comparing the cost with max cost inside the while loop.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Pankaj Kumar <pankaj.km@samsung.com>
---
 fs/f2fs/gc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ddc2c67..3a9df36 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -241,14 +241,14 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 {
 	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
 	struct victim_sel_policy p;
-	unsigned int secno;
+	unsigned int secno, max_cost;
 	int nsearched = 0;
 
 	p.alloc_mode = alloc_mode;
 	select_policy(sbi, gc_type, type, &p);
 
 	p.min_segno = NULL_SEGNO;
-	p.min_cost = get_max_cost(sbi, &p);
+	p.min_cost = max_cost = get_max_cost(sbi, &p);
 
 	mutex_lock(&dirty_i->seglist_lock);
 
@@ -287,7 +287,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 			p.min_cost = cost;
 		}
 
-		if (cost == get_max_cost(sbi, &p))
+		if (cost == max_cost)
 			continue;
 
 		if (nsearched++ >= MAX_VICTIM_SEARCH) {
@@ -295,8 +295,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 			break;
 		}
 	}
-got_it:
 	if (p.min_segno != NULL_SEGNO) {
+got_it:
 		if (p.alloc_mode == LFS) {
 			secno = GET_SECNO(sbi, p.min_segno);
 			if (gc_type == FG_GC)
-- 
1.7.9.5


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
