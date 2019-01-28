From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 087/304] f2fs: avoid build warn of
 fall_through
Date: Mon, 28 Jan 2019 10:40:04 -0500
Message-ID: <20190128154341.47195-87-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1go98C-0007H8-Ce
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 15:47:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1go98A-003R7X-JZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 15:47:28 +0000
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit f5d5510e7389fa264337fb524346bac9eb93adc8 ]

After merging the f2fs tree, today's linux-next build
 (x86_64_allmodconfig) produced this warning:

 In file included from fs/f2fs/dir.c:11:
 fs/f2fs/f2fs.h: In function '__mark_inode_dirty_flag':
 fs/f2fs/f2fs.h:2388:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
    if (set)
       ^
 fs/f2fs/f2fs.h:2390:2: note: here
   case FI_DATA_EXIST:
   ^~~~

 Exposed by my use of -Wimplicit-fallthrough

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1e031971a466..ebad864c031c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2370,6 +2370,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_NEW_INODE:
 		if (set)
 			return;
+		/* fall through */
 	case FI_DATA_EXIST:
 	case FI_INLINE_DOTS:
 	case FI_PIN_FILE:
-- 
2.19.1
