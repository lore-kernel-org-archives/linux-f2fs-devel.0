From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [PATCH 0/7] f2fs: some fix and cleanup about flush_merge
Date: Fri, 11 Apr 2014 17:49:25 +0800
Message-ID: <5347BAA5.6070104@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WYYEt-0002wE-Ix
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Apr 2014 09:59:15 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WYYEs-0008Uc-CY for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Apr 2014 09:59:15 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Kim <jaegeuk.kim@samsung.com>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>

Gu Zheng (7):
  f2fs: put the bio when issue_flush completed
  f2fs: remove the unuseful "issue_tail" list
  f2fs: use __GFP_ZERO to avoid appending set-NULL
  f2fs: enable flush_merge only in f2fs is not read-only
  f2fs: add the flush_merge handle in the remount flow
  f2fs: introduce struct flush_cmd_control to wrap the flush_merge
    fields
  f2fs: introduce help function {create,destroy}_flush_cmd_control

 fs/f2fs/f2fs.h    |   17 ++++++---
 fs/f2fs/segment.c |  102 +++++++++++++++++++++++++++++++++++-----------------
 fs/f2fs/super.c   |   32 ++++++++++++++--
 3 files changed, 107 insertions(+), 44 deletions(-)

-- 
1.7.7



------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
