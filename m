From: DongOh Shin <doscode.kr@gmail.com>
Subject: [PATCH 0/2] Fix 3 coding style errors and 447 warnings
	in f2fs.h
Date: Mon, 30 Jan 2017 10:55:16 -0800
Message-ID: <20170130185518.916-1-doscode.kr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <doscode.kr@gmail.com>) id 1cYH6z-00025a-V0
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Jan 2017 18:55:33 +0000
Received: from mail-pf0-f194.google.com ([209.85.192.194])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cYH6z-0003bq-5N
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Jan 2017 18:55:33 +0000
Received: by mail-pf0-f194.google.com with SMTP id y143so23858427pfb.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 30 Jan 2017 10:55:33 -0800 (PST)
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
The patches resolve 3 errors and 446 warnings below:
0001, error,   "Macros with complex values should be enclosed in parentheses"
0001, error,   "space prohibited before that ',' (ctx:WxW)"
0002, warning, "Missing a blank line after declarations"
0002, warning, "function definition argument 'x' should also have an identifier name"
0002, warning, "macros should not use a trailing semicolon"

So there are only 8 warnings in f2fs.h after applying these.
The patches are tested under 'next-20170125'.
Thanks,

DongOh Shin (2):
  Fix 3 coding style errors in f2fs.h
  Fix 446 coding style warnings in f2fs.h

 fs/f2fs/f2fs.h | 502 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 272 insertions(+), 230 deletions(-)

-- 
1.8.3.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
