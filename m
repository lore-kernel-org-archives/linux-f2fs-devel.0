From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: f2fs stability problems keep me from testing
Date: Thu, 19 Nov 2015 02:42:19 +0100
Message-ID: <20151119014219.GA6973@schmorp.de>
References: <20151117172430.GA6945@schmorp.de>
	<004b01d121e8$10563730$3102a590$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1ZzEF2-0002PK-Nh
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Nov 2015 01:42:28 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZzEF0-0004yF-NE
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Nov 2015 01:42:28 +0000
Content-Disposition: inline
In-Reply-To: <004b01d121e8$10563730$3102a590$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Wed, Nov 18, 2015 at 06:00:40PM +0800, Chao Yu <chao2.yu@samsung.com> wrote:
> I ran fsck, and it have all "Ok" messages, I can run it again, but would

Anyways, here is the fsck output - it was made after the reboot, a fsck, and
two mounts, I think (also, kernel was upgraded).

PS: there is a typo ("matcing", don't know if it's still in git).

   Info: sector size = 512
   Info: total sectors = 15628050432 (7630884 MB)
   Info: MKFS version
     "Linux version 3.18.21-031821-generic (kernel@gloin) (gcc version 4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04) ) #201509020527 SMP Wed Sep 2 05:29:06 UTC 2015"
   Info: FSCK version
     from "Linux version 3.18.24-031824-generic (kernel@gomeisa) (gcc version 4.9.2 (Ubuntu 4.9.2-10ubuntu13) ) #201511031331 SMP Tue Nov 3 18:33:52 UTC 2015"
       to "Linux version 3.18.24-031824-generic (kernel@gomeisa) (gcc version 4.9.2 (Ubuntu 4.9.2-10ubuntu13) ) #201511031331 SMP Tue Nov 3 18:33:52 UTC 2015"
   Info: superblock features = 0 : 
   Info: superblock encrypt level = 0, salt = 00000000000000000000000000000000
   Info: total FS sectors = 15628050432 (7630884 MB)
   Info: CKPT version = 14c2
   Info: checkpoint state = 5 :  compacted_summary unmount

   [FSCK] Unreachable nat entries                        [Ok..] [0x0]
   [FSCK] SIT valid block bitmap checking                [Ok..]
   [FSCK] Hard link checking for regular file            [Ok..] [0x0]
   [FSCK] valid_block_count matching with CP             [Ok..] [0x24dad5a5]
   [FSCK] valid_node_count matcing with CP (de lookup)   [Ok..] [0x9773e]
   [FSCK] valid_node_count matcing with CP (nat lookup)  [Ok..] [0x9773e]
   [FSCK] valid_inode_count matched with CP              [Ok..] [0x21bc]
   [FSCK] free segment_count matched with CP             [Ok..] [0x27ab81]
   [FSCK] next block offset is free                      [Ok..]
   [FSCK] fixing SIT types
   [FSCK] other corrupted bugs                           [Ok..]

   Done.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------
