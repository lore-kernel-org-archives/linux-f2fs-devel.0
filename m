From: Jens Axboe <axboe@fb.com>
Subject: Re: [GIT PULL] f2fs for 4.8
Date: Wed, 27 Jul 2016 12:29:38 -0600
Message-ID: <86e4eb4c-3cb8-8e0f-ebb4-48cdf4dea8e8@fb.com>
References: <20160727040800.GA69756@jaegeuk>
	<CA+55aFwnNLqsuL_LwAV4OYQf9v+pje5w=OwoE=oA-R8QpXB-Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <prvs=601666d96b=axboe@fb.com>) id 1bSTad-000727-Fr
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jul 2016 18:29:55 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bSTab-0001kF-NV
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jul 2016 18:29:55 +0000
In-Reply-To: <CA+55aFwnNLqsuL_LwAV4OYQf9v+pje5w=OwoE=oA-R8QpXB-Cg@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>

On 07/27/2016 11:46 AM, Linus Torvalds wrote:
> On Tue, Jul 26, 2016 at 9:08 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.8
>
> This got some merge conflicts with the bio interface rework
> (bio_set_op_attrs() etc), and while I tried to fix it up, I don't have
> any sane way to test the end result, so I might have screwed up
> royally.
>
> My resolution looks sane to me, and compiles, but that's all I'm
> really going to guarantee. Can you please give it a good round of
> testing, and Jens, can you check it out too. In particular, the
> fs/f2fs/data.c changes is what I might have screwed up..

Looks OK to me, though I think you could have dropped the ->bi_rw
assignment in f2fs_submit_page_bio():

         bio->bi_rw = fio->op_flags;
         bio_set_op_attrs(bio, fio->op, fio->op_flags);

         __submit_bio(fio->sbi, bio, fio->type);

-- 
Jens Axboe


------------------------------------------------------------------------------
