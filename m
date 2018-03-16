From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH-Review] f2fs: Set GF_NOFS in read_cache_page_gfp while doing f2fs_quota_read
Date: Fri, 16 Mar 2018 18:53:52 +0530
Message-ID: <1521206633-21378-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: stummala@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hello,

Observed below deadlock with quota enabled on f2fs during low memory situation.
I think during f2fs_quota_enable -> which is doing read_cache_page with __GFP_FS
flag set, due to low memory this is causing shrinker to get invoked
and thus going into a deadlock due to mutex lock in dquota. Commit details
in next patch contains the call stack.

Since I did not had the quota enabled on f2fs configuration, I could not test
this on my setup yet.

Could the community kindly review and let me know if the patch
is correct or not ?


Ritesh Harjani (1):
  f2fs: Set GF_NOFS in read_cache_page_gfp while doing f2fs_quota_read

 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
