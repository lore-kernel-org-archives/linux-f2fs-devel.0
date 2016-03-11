From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/8] some cleanup of inline flag checking
Date: Fri, 11 Mar 2016 11:28:00 +0800
Message-ID: <1457666880-14311-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net


This patchset is going to remove some redunant checking
of inline data flag and also going to avoid some unnecessary
cpu waste when doing inline stuff.

Note:
Sorry for sending previous four patches in separate, let
drop them and make them in this thread for better review.



Shawn Lin (8):
  f2fs: check inline flag ahead for f2fs_write_inline_data
  f2fs: remove checing inline data flag for f2fs_write_data_page
  f2fs: check inline flag ahead for f2fs_read_inline_data
  f2fs: remove redundant checking of inline data flag
  f2fs: f2fs: check inline flag ahead for f2fs_inline_data_fiemap
  f2fs: remove checing inline data flag for f2fs_fiemap
  f2fs: remove unnecessary inline checking for f2fs_convert_inline_inode
  f2fs: check inline flag ahead for get_dnode_of_data

 fs/f2fs/data.c   | 17 +++++++----------
 fs/f2fs/inline.c | 27 ++++++++++-----------------
 fs/f2fs/node.c   | 12 +++++-------
 3 files changed, 22 insertions(+), 34 deletions(-)

-- 
2.3.7
