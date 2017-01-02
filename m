From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: don't reserve block for empty file when
 convert inline, page
Date: Mon, 2 Jan 2017 22:56:46 +0800
Message-ID: <65c348f6-48ce-e810-72f4-0bf86c39d0b6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1cO42m-0006Kn-E7
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Jan 2017 14:57:00 +0000
Received: from mail-pf0-f195.google.com ([209.85.192.195])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cO42l-0000ml-NA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Jan 2017 14:57:00 +0000
Received: by mail-pf0-f195.google.com with SMTP id i88so24546589pfk.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 02 Jan 2017 06:56:59 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

A test program gets the SEEK_DATA with two values between
a new created file and the exist file on f2fs filesystem. 

F2FS filesystem,  (the first "test1" is a new file)
# ./lseektest /f2fs/test1
SEEK_DATA size != 0 (offset = 8192)
# ./lseektest /f2fs/test1
SEEK_DATA size != 0 (offset = 4096)

PNFS filesystem, (the first "test1" is a new file)
# ./lseektest /pnfs/test1
SEEK_DATA size != 0 (offset = 4096)
# ./lseektest /pnfs/test1
SEEK_DATA size != 0 (offset = 4096)

# cat lseektest.c

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#ifndef SEEK_DATA
#define SEEK_DATA      3
#define SEEK_HOLE      4
#endif

int main(int argc, char **argv)
{
        char *filename = argv[1];
        int offset = 1, i = 0, fd = -1;

        if (argc < 2) {
                printf("Usage: %s f2fsfilename\n", argv[0]);
                return -1;
        }

        /*
        if (!access(filename, F_OK) || errno != ENOENT) {
                printf("Needs a new file for test, %m\n");
                return -1;
        }*/

        fd = open(filename, O_RDWR | O_CREAT, 0777);
        if (fd < 0) {
                printf("Create test file %s failed, %m\n", filename);
                return -1;
        }

        for (i = 0; i < 20; i++) {
                offset = 1 << i;
                ftruncate(fd, 0);
                lseek(fd, offset, SEEK_SET);
                write(fd, "test", 5);
                /* Get the alloc size by seek data equal zero*/
                if (lseek(fd, 0, SEEK_DATA)) {
                        printf("SEEK_DATA size != 0 (offset = %d)\n", offset);
                        break;
                }
        }

        close(fd);
        return 0;
}

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e32a9e5..6c8d099 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -117,7 +117,7 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	};
 	int dirty, err;
 
-	if (!f2fs_exist_data(dn->inode))
+	if (!f2fs_exist_data(dn->inode) || !i_size_read(dn->inode))
 		goto clear_out;
 
 	err = f2fs_reserve_block(dn, 0);
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
