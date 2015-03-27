From: JP Abgrall <jpa@google.com>
Subject: Re: fsck handling of inode incorrectly used as DIR and
	REG_FILE?
Date: Fri, 27 Mar 2015 10:38:05 -0700
Message-ID: <CAKP4w2QUJJ-RHn+gJJFaj3zaC0-4rWhhhtcN=jx4EPMnET1OrA@mail.gmail.com>
References: <CAKP4w2QLJCVruiyta6=FQ8AomPYogPx9uKfBkxvYMUhLYDCX9Q@mail.gmail.com>
	<20150327000609.GA67016@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jpa@google.com>) id 1YbYDH-0001MH-S6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 17:38:31 +0000
Received: from mail-qg0-f43.google.com ([209.85.192.43])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YbYDH-0008JT-18
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Mar 2015 17:38:31 +0000
Received: by qgfa8 with SMTP id a8so132846359qgf.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 27 Mar 2015 10:38:25 -0700 (PDT)
In-Reply-To: <20150327000609.GA67016@jaegeuk-mac02>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

The 6 patches worked for my case. This one seems to have done the work:
    fsck.f2fs: remove inconsistent named directories


   [__chk_dentries: 804] [  5]-[0x8] name[rJx8QtCT5u-dJsmZ4GOp2ahzwPs]
len[0x1b] ino[0x24e49] type[0x2]
    [ASSERT] (sanity_check_nid: 296)  --> mismatch name [0x24e49]
[rJx8QtCT5u-dJsmZ4GOp2ahzwPs vs. de7e59c967696ac0_0]
    [FIX] (__chk_dentries: 823)  --> Unlink [0x24e49] -
rJx8QtCT5u-dJsmZ4GOp2ahzwPs len[0x1b], type[0x2]
    ...
    [__chk_dentries: 804] [  5]-[0x6f] name[de7e59c967696ac0_0]
len[0x12] ino[0x24e49] type[0x1]
    [ASSERT] (fsck_chk_inode_blk: 556)  --> ino: 0x24e49 has i_blocks:
00000001, but has 3 blocks
    [FIX] (fsck_chk_inode_blk: 561)  --> [0x24e49] i_blocks=0x00000001 -> 0x3

Thanks.

On Thu, Mar 26, 2015 at 5:06 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> I found that fsck.f2fs has some missing cases.
> And it seems that one of them is very similar with your issue.
> Could you test the patches that I submitted seconds ago?

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
