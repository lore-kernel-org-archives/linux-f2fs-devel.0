From: Jens Axboe <axboe@fb.com>
Subject: Re: [GIT PULL] f2fs for 4.8
Date: Wed, 27 Jul 2016 12:47:46 -0600
Message-ID: <a8450633-7999-12d1-9554-85020c062eb2@fb.com>
References: <20160727040800.GA69756@jaegeuk>
 <CA+55aFwnNLqsuL_LwAV4OYQf9v+pje5w=OwoE=oA-R8QpXB-Cg@mail.gmail.com>
 <86e4eb4c-3cb8-8e0f-ebb4-48cdf4dea8e8@fb.com>
 <CA+55aFx+v=iM2t+4OhF2AqbdszNYWt6677C2LvX-iYmDEnh_Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFx+v=iM2t+4OhF2AqbdszNYWt6677C2LvX-iYmDEnh_Rg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 07/27/2016 12:46 PM, Linus Torvalds wrote:
> On Wed, Jul 27, 2016 at 11:29 AM, Jens Axboe <axboe@fb.com> wrote:
>>
>> Looks OK to me, though I think you could have dropped the ->bi_rw
>> assignment in f2fs_submit_page_bio():
>>
>>         bio->bi_rw = fio->op_flags;
>>         bio_set_op_attrs(bio, fio->op, fio->op_flags);
>>
>>         __submit_bio(fio->sbi, bio, fio->type);
>
> Ahh, yes. I'll add a patch to drop that line, unless you just want to
> do it yourself (or Jaegeuk Kim wants to do it in the f2fs tree).

I've got a few more things coming in this merge window, so I can just 
queue that up.

> Jaegeuk, I'd still really want confirmation that it all actually
> works. The extra line should be harmless, even if Jens is right that
> it is ugly and wrong. It might be worth testing with that line
> removed.

Yes please, I don't have an easy way to test it either.

-- 
Jens Axboe
