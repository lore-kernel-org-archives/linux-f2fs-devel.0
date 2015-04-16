From: Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH] f2fs: remove duplicated code in the
	f2fs_lookup()
Date: Fri, 17 Apr 2015 02:37:15 +0900
Message-ID: <CAMArcTXXLLTo3hwxSyzKQ_PygdeHbsKPzV66N84bea05NY8a7w@mail.gmail.com>
References: <1429173763-12707-1-git-send-email-ap420073@gmail.com>
	<20150416170022.GA20307@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ap420073@gmail.com>) id 1Yinj8-0005cg-Mx
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Apr 2015 17:37:22 +0000
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Yinj7-0001D8-PB
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Apr 2015 17:37:22 +0000
Received: by widjs5 with SMTP id js5so16803016wid.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 16 Apr 2015 10:37:15 -0700 (PDT)
In-Reply-To: <20150416170022.GA20307@jaegeuk-mac02>
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

2015-04-17 2:00 GMT+09:00 Jaegeuk Kim <jaegeuk@kernel.org>:
> Hi Taehee,
>
> On Thu, Apr 16, 2015 at 05:42:43PM +0900, Taehee Yoo wrote:
>> in the f2fs_lookup(), checks that inode isn't null
>> but d_splice_alias() has same routine at first line.
>> so i remove this routine.
>
> In the latest f2fs, we cannot merge this patch.
> Since some inline_dots codes were added with a valid inode before
> d_splice_alias.
>
> Thanks,
>
>>
>> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
>> ---
>>  fs/f2fs/namei.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index e79639a9..f17b4b5 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -204,8 +204,6 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>>               f2fs_put_page(page, 0);
>>
>>               inode = f2fs_iget(dir->i_sb, ino);
>> -             if (IS_ERR(inode))
>> -                     return ERR_CAST(inode);
>>       }
>>
>>       return d_splice_alias(inode, dentry);
>> --
>> 1.9.1


apologize about imperfect patch.
Thank you for your review!

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
