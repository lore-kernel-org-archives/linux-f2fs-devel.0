From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH] f2fs: Return the errno to the caller to avoid using a
 wrong page
Date: Fri, 27 May 2016 20:22:04 +0800
Message-ID: <57483BEC.8020402@huawei.com>
References: <1464181261-3980-1-git-send-email-yunlong.song@huawei.com>
 <20160525165438.GB47096@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525165438.GB47096@jaegeuk.gateway>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: cm224.lee@samsung.com, yuchao0@huawei.com, chao@kernel.org, sylinux@163.com, bintian.wang@huawei.com, houpengyang@huawei.com, heyunlei@huawei.com, liushuoran@huawei.com, shiguojun@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/5/26 0:54, Jaegeuk Kim wrote:
> Hi Yunlong,
> 
> Do we have a bug report in terms of this?
> 

Hi Kim,
    I found the old following patch, you have mentioned one reason why "nid != nid_of_node(page)" in
that commit message.

http://git.kernel.org/cgit/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=3bb5e2c8fe2296ddd9d864dcfb5ee1b77135f3ec

commit 3bb5e2c8fe2296ddd9d864dcfb5ee1b77135f3ec
Author: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Date:   Tue Apr 1 17:38:26 2014 +0900

    f2fs: return -EIO when node id is not matched

    During the cleaing of node segments, F2FS can get errored node blocks due to
    data race between node page lock and its valid bitmap operations.
    In that case, it needs to return an error to skip such the obsolete block copy.

    Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index eced8d7..065cd99 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -958,7 +958,7 @@ repeat:
                goto got_it;

        lock_page(page);
-       if (unlikely(!PageUptodate(page))) {
+       if (unlikely(!PageUptodate(page) || nid != nid_of_node(page))) {
                f2fs_put_page(page, 1);
                return ERR_PTR(-EIO);
        }
@@ -967,7 +967,6 @@ repeat:
                goto repeat;
        }
 got_it:
-       f2fs_bug_on(nid != nid_of_node(page));
        mark_page_accessed(page);
        return page;
 }



-- 
Thanks,
Yunlong Song
