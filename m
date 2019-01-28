From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 046/170] f2fs: avoid build warn of fall_through
Date: Mon, 28 Jan 2019 11:09:56 -0500
Message-ID: <20190128161200.55107-46-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Sasha Levin <sashal@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

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
index 3f1a44696036..d2873f227072 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2014,6 +2014,7 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
 	case FI_INLINE_DENTRY:
 		if (set)
 			return;
+		/* fall through */
 	case FI_DATA_EXIST:
 	case FI_INLINE_DOTS:
 		f2fs_mark_inode_dirty_sync(inode, true);
-- 
2.19.1
