From: xiakaixu <xiakaixu@huawei.com>
Subject: there are unencrypted files in an encrypted directory in
	F2FS
Date: Mon, 19 Sep 2016 12:16:16 +0800
Message-ID: <57DF6690.9080305@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xiakaixu@huawei.com>) id 1blq0k-0003Hk-B0
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Sep 2016 04:16:54 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1blq0g-00013b-AX
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 19 Sep 2016 04:16:54 +0000
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
Cc: guoweichao@huawei.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi Kim,

According to the encryption design policy "all of the  files or
subdirectories in an encrypted directory must be encrypted". But
the current f2fs code seems allow to there are unencrypted files
in an encrypted directory. For example, the f2fs_create() and
f2fs_mknod() functions call f2fs_new_inode() to check the child inode.

         /* If the directory encrypted, then we should encrypt the inode. */
   	if (f2fs_encrypted_inode(dir) && f2fs_may_encrypt(inode))
                 f2fs_set_encrypted_inode(inode);

	static inline bool f2fs_may_encrypt(struct inode *inode)
	{
	#ifdef CONFIG_F2FS_FS_ENCRYPTION
         	umode_t mode = inode->i_mode;

	        return (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode));
	#else
         	return 0;
	#endif
	}

So even if the child inode is not REG/DIR/LNK and it still can be created
successfully which is unencrypted file. Instead, maybe here we can return
-EACCESS. Not sure about it :)

-- 
Regards
Kaixu Xia


------------------------------------------------------------------------------
