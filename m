From: kbuild test robot <fengguang.wu@intel.com>
Subject: [f2fs:dev-test 59/63] fs/f2fs/dir.c:676:8-15: ERROR:
 PTR_ERR applied after initialization to constant on line 650
Date: Sat, 18 Feb 2017 09:22:44 +0800
Message-ID: <201702180939.gG733krI%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fengguang.wu@intel.com>) id 1cetkH-00068u-Dv
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Feb 2017 01:23:29 +0000
Received: from mga05.intel.com ([192.55.52.43])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cetkG-0007QT-Cb
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 18 Feb 2017 01:23:29 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
head:   d73e9520359023105b87050ee82aa112a357a2fd
commit: 9fdd0bb26d924f702fe575f864c30eaa60a1797e [59/63] f2fs: fix multiple f2fs_add_link() calls having same name


coccinelle warnings: (new ones prefixed by >>)

>> fs/f2fs/dir.c:676:8-15: ERROR: PTR_ERR applied after initialization to constant on line 650

vim +676 fs/f2fs/dir.c

   644	 * f2fs_unlock_op().
   645	 */
   646	int __f2fs_add_link(struct inode *dir, const struct qstr *name,
   647					struct inode *inode, nid_t ino, umode_t mode)
   648	{
   649		struct fscrypt_name fname;
 > 650		struct page *page = NULL;
   651		struct f2fs_dir_entry *de = NULL;
   652		int err;
   653	
   654		err = fscrypt_setup_filename(dir, name, 0, &fname);
   655		if (err)
   656			return err;
   657	
   658		/*
   659		 * An immature stakable filesystem shows a race condition between lookup
   660		 * and create. If we have same task when doing lookup and create, it's
   661		 * definitely fine as expected by VFS normally. Otherwise, let's just
   662		 * verify on-disk dentry one more time, which guarantees filesystem
   663		 * consistency more.
   664		 */
   665		if (current != F2FS_I(dir)->task) {
   666			de = __f2fs_find_entry(dir, &fname, &page);
   667			F2FS_I(dir)->task = NULL;
   668		}
   669		if (de) {
   670			f2fs_dentry_kunmap(dir, page);
   671			f2fs_put_page(page, 0);
   672			err = -EEXIST;
   673		} else if (!IS_ERR(page)) {
   674			err = __f2fs_do_add_link(dir, &fname, inode, ino, mode);
   675		} else {
 > 676			err = PTR_ERR(page);
   677		}
   678		fscrypt_free_filename(&fname);
   679		return err;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
