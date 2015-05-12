From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: get rid of buggy function
Date: Mon, 11 May 2015 23:00:30 -0700
Message-ID: <20150512060030.GA25143@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1431402528-24156-1-git-send-email-jaegeuk@kernel.org>
 <1431402528-24156-3-git-send-email-jaegeuk@kernel.org>
 <0DE36CEE-3086-4727-9B7B-58D784941567@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0DE36CEE-3086-4727-9B7B-58D784941567@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, May 12, 2015 at 12:10:16AM -0400, Nicholas Krause wrote:
> 
> 
> On May 11, 2015 11:48:48 PM EDT, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >This patch avoids to use a buggy function for now.
> >It needs to fix it later.
> >
> >Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >---
> > fs/f2fs/segment.c | 15 ++++++++++-----
> > 1 file changed, 10 insertions(+), 5 deletions(-)
> >
> >diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >index 342e0f7..17e89ba 100644
> >--- a/fs/f2fs/segment.c
> >+++ b/fs/f2fs/segment.c
> >@@ -64,6 +64,8 @@ static inline unsigned long __reverse_ffs(unsigned
> >long word)
> > 	return num;
> > }
> > 
> >+/* FIXME: Do not use this due to a subtle bug */
> >+#if 0
> > /*
> >* __find_rev_next(_zero)_bit is copied from lib/find_next_bit.c because
> >  * f2fs_set_bit makes MSB and LSB reversed in a byte.
> >@@ -122,6 +124,7 @@ found_first:
> > found_middle:
> > 	return result + __reverse_ffs(tmp);
> > }
> >+#endif
> > 
> >static unsigned long __find_rev_next_zero_bit(const unsigned long
> >*addr,
> > 			unsigned long size, unsigned long offset)
> >@@ -542,7 +545,7 @@ static void add_discard_addrs(struct f2fs_sb_info
> >*sbi, struct cp_control *cpc)
> > 	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
> > 	unsigned long *discard_map = (unsigned long *)se->discard_map;
> > 	unsigned long *dmap = SIT_I(sbi)->tmp_map;
> >-	unsigned int start = 0, end = -1;
> >+	unsigned int start = -1, end = 0;
> > 	bool force = (cpc->reason == CP_DISCARD);
> > 	int i;
> > 
> >@@ -561,12 +564,14 @@ static void add_discard_addrs(struct f2fs_sb_info
> >*sbi, struct cp_control *cpc)
> > 				(cur_map[i] ^ ckpt_map[i]) & ckpt_map[i];
> > 
> > 	while (force || SM_I(sbi)->nr_discards <= SM_I(sbi)->max_discards) {
> >-		start = __find_rev_next_bit(dmap, max_blocks, end + 1);
> >-		if (start >= max_blocks)
> >-			break;
> > 
> > 		end = __find_rev_next_zero_bit(dmap, max_blocks, start + 1);
> >-		__add_discard_entry(sbi, cpc, se, start, end);
> >+
> >+		__add_discard_entry(sbi, cpc, se, start + 1, end);
> >+
> >+		if (end >= max_blocks)
> >+			break;
> >+		start = end;
> > 	}
> > }
> > 
> Rather then avoid that  function, why not fix it.  This seems to add more work in the future and due to this I would like recommend fixing the function,__find_rev_next_zero now. 
> IMHO, 

Agreed.
But, in the mean time, it'd be necessary to avoid the bug.
And, I think this will not cause any additional work, since this is a somewhat
f2fs-only function used in very corner cases.

Thanks,

> Nick 
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
