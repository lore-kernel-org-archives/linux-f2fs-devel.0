From: Huajun Li <huajun.li@intel.com>
Subject: [f2fs-dev] [RFC 0/5] Enable f2fs support inline data
Date: Mon,  3 Jun 2013 18:04:09 +0800
Message-ID: <1370253854-15084-1-git-send-email-huajun.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huajun.li@intel.com>) id 1UjRd7-0007kJ-JY
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Jun 2013 10:04:45 +0000
Received: from mga14.intel.com ([143.182.124.37])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UjRd6-0006Vy-MR for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Jun 2013 10:04:45 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com, linux-fsdevel@vger.kernel.org, huajun.li.lee@gmail.com
Cc: namjae.jeon@samsung.com, Huajun Li <huajun.li@intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

f2fs inode is so large, small files can be stored directly in the inode,
rather than just storing a single block address and storing the data elsewhere.

This RFC patch set is just to enable f2fs support inline data: files less than
about 3.6K can be stored directly in inode block.

TODO: make small dirs inline too.


Haicheng Li (3):
  f2fs: Add helper functions and flag to support inline data
  f2fs: Add interface for inline data support
  f2fs: add tracepoints to debug inline data operations

Huajun Li (2):
  f2fs: Handle inline data read and write
  f2fs: Key functions to handle inline data

 fs/f2fs/Kconfig             |   10 +++
 fs/f2fs/Makefile            |    1 +
 fs/f2fs/data.c              |   78 +++++++++++++++++++++-
 fs/f2fs/f2fs.h              |   70 +++++++++++++++++++
 fs/f2fs/file.c              |    9 ++-
 fs/f2fs/inline.c            |  156 +++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/inode.c             |    8 +++
 include/linux/f2fs_fs.h     |    5 ++
 include/trace/events/f2fs.h |   69 +++++++++++++++++++
 9 files changed, 402 insertions(+), 4 deletions(-)
 create mode 100644 fs/f2fs/inline.c

-- 
1.7.9.5


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
