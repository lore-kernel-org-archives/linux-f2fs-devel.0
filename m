From: Changman Lee <cm224.lee@samsung.com>
Subject: f2fs_write_inode
Date: Mon, 01 Dec 2014 18:42:28 +0900
Message-ID: <20141201094228.GA7824@lcm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1XvNWL-0002pJ-FK
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 01 Dec 2014 09:43:53 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XvNWJ-0003b7-IV
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 01 Dec 2014 09:43:53 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0NFW00LPWDOVWD00@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 01 Dec 2014 18:43:43 +0900 (KST)
Received: from localhost ([12.36.79.189])
	by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
	(7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTPA id <0NFW0073MDOV0VI1@mmp2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 01 Dec 2014 18:43:43 +0900 (KST)
Content-disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hi guys,

I was wondering why f2fs_write_inode doesn't submit any I/O according to
wbc->sync_mode.
If you have any idea, answer to my questions, please.

And at f2fs_sync_file,

	if (need_cp) {

Q: We've already called sync_fs. Is there any scenario like below ?
I refered to 354a3399dc6f7e556d04e1c731cd50e08eeb44bd but I can't guess the situation.

		if (file_wrong_pino(inode) && inode->i_nlink == 1 &&
					get_parent_ino(inode, &pino)) {
			fi->i_pino = pino;
			file_got_pino(inode);
			up_write(&fi->i_sem);
			mark_inode_dirty_sync(inode);

Q: Update but no write I/O. How to recover after SPO ?

			ret = f2fs_write_inode(inode, NULL);
			if (ret)
				goto out;
		} else {
			up_write(&fi->i_sem);
		}
	} else {

~ snip ~

out:
	return ret;


Regards,
Changman

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
