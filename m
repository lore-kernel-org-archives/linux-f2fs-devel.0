From: =?gb2312?B?WXUgWGluZyAo0M/T7ik=?= <Yu.Xing@spreadtrum.com>
Subject: f2fs-tools support packing file into android image ?
Date: Sun, 22 Jan 2017 02:20:23 +0000
Message-ID: <e99b12d6c839419395deafc513bcc862@SHMBX01.spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Yu.Xing@spreadtrum.com>) id 1cV8SE-00069f-2c
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Jan 2017 03:04:30 +0000
Received: from [222.66.158.135] (helo=SHSQR01.spreadtrum.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cV8S3-0000bP-Ic
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 22 Jan 2017 03:04:30 +0000
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id v0M2LQmh064002
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 22 Jan 2017 10:21:26 +0800 (CST)
	(envelope-from Yu.Xing@spreadtrum.com)
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "jpa@google.com" <jpa@google.com>, "drosen@google.com" <drosen@google.com>, "enh@google.com" <enh@google.com>, "salyzyn@google.com" <salyzyn@google.com>, "jeffv@google.com" <jeffv@google.com>"salyzyn@google.com" <salyzyn@google.com>, "ccross@android.com" <ccross@android.com>, "danalbert@google.com" <danalbert@google.com>
Cc: "mdxy2014@gmail.com" <mdxy2014@gmail.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi 

	Recently, I used the make_f2fs command to create android system.img/userdata.img/cache.img.
	The tool from system/extras/f2fs_utils/

	But I found the make_f2fs cannot packing file into image, so I can not apply the tool to format the system.img 
	If we used the tool to format the system.img, it can format succeed, but when we mount the system.img to
    target, there is no exist any files in the target directory!

	So currently,  this tool can support packing files into android image ? 
	From make_ext4fs tool, I found this tool can packing the files into images with the target_out_directory arguments, 
	as following:

	make_ext4fs [ -l <len> ] [ -j <journal size> ] [ -b <block_size> ]
    [ -g <blocks per group> ] [ -i <inodes> ] [ -I <inode size> ]
    [ -L <label> ] [ -f ] [ -a <android mountpoint> ] [ -u ]
    [ -S file_contexts ] [ -C fs_config ] [ -T timestamp ]
    [ -z | -s ] [ -w ] [ -c ] [ -J ] [ -v ] [ -B <block_list_file> ]
    <filename> [[<directory>] <target_out_directory>] 

	But make_f2fs tool cannot support this function, this tool only can support -l arguments , as following:
	make_f2fs -l <len> <filename>

	Also, if we want to include the selinux related, for make_ext4fs, we can used the -S arguments.
	But for make_f2fs, we cannot , maybe add this function into make_f2fs tool ? 

	Can somebody help me to have a look at these questions?  Thanks a lot!

Yu.xing 
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
