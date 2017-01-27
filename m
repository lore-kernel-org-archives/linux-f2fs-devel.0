From: DongOh Shin <doscode.kr@gmail.com>
Subject: [PATCH 0/5] Fix coding style errors and warnings in
	f2fs.h
Date: Fri, 27 Jan 2017 10:29:35 -0800
Message-ID: <20170127182940.11389-1-doscode.kr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <doscode.kr@gmail.com>) id 1cXBHh-0004NW-UE
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Jan 2017 18:30:05 +0000
Received: from mail-pf0-f193.google.com ([209.85.192.193])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cXBHh-0008T1-6E
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Jan 2017 18:30:05 +0000
Received: by mail-pf0-f193.google.com with SMTP id e4so18990417pfg.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 27 Jan 2017 10:30:05 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: doscode.kr@gmail.com, linux-f2fs-devel@lists.sourceforge.net

f2fs.h has 3 errors and 454 warnings on the coding style.
This series of patches resolve 3 errors and 446 warnings below:
0001, error,   "Macros with complex values should be enclosed in parentheses"
0002, error,   "space prohibited before that ',' (ctx:WxW)"
0003, warning, "Missing a blank line after declarations"
0004, warning, "function definition argument 'x' should also have an identifier name"
0005, warning, "macros should not use a trailing semicolon"

So, after applying this patch, it is reduced to 8 warnings only.

DongOh Shin (5):
  Fix coding style errors in f2fs.h
  Fix coding style error in f2fs.h
  Fix coding style warnings in f2fs.h
  Fix coding style warnings in f2fs.h
  Fix coding style warnings in f2fs.h

 fs/f2fs/f2fs.h | 502 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 272 insertions(+), 230 deletions(-)

-- 
1.8.3.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
