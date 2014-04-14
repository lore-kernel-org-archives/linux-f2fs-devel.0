From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 0/7] f2fs: some fix and cleanup about
	flush_merge
Date: Mon, 14 Apr 2014 09:18:04 +0800
Message-ID: <534B374C.8030009@cn.fujitsu.com>
References: <5347BAA5.6070104@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1WZVgc-0004JS-0j
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Apr 2014 01:27:50 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WZVga-0007Qg-WA for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Apr 2014 01:27:49 +0000
In-Reply-To: <5347BAA5.6070104@cn.fujitsu.com>
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

Hi All,
There seems to be a mistake in "[PATCH 2/7]f2fs: remove the unuseful "issue_tail" list",
and the whole patchset needs to be reworked. So please ignore this one.
Sorry for the noise.

Regards,
Gu
On 04/11/2014 05:49 PM, Gu Zheng wrote:

> Gu Zheng (7):
>   f2fs: put the bio when issue_flush completed
>   f2fs: remove the unuseful "issue_tail" list
>   f2fs: use __GFP_ZERO to avoid appending set-NULL
>   f2fs: enable flush_merge only in f2fs is not read-only
>   f2fs: add the flush_merge handle in the remount flow
>   f2fs: introduce struct flush_cmd_control to wrap the flush_merge
>     fields
>   f2fs: introduce help function {create,destroy}_flush_cmd_control
> 
>  fs/f2fs/f2fs.h    |   17 ++++++---
>  fs/f2fs/segment.c |  102 +++++++++++++++++++++++++++++++++++-----------------
>  fs/f2fs/super.c   |   32 ++++++++++++++--
>  3 files changed, 107 insertions(+), 44 deletions(-)
> 



------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
