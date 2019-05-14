From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: issue discard commands proactively in
 high fs utilization
Date: Tue, 14 May 2019 16:29:32 +0800
Message-ID: <73fc6da8-7b89-3b02-8856-bd6876c50259@huawei.com>
References: <20180529205048.39694-1-jaegeuk@kernel.org>
 <CAD14+f154_t1-TbbSDb9xV_ikDAWfF+8H7aOSK4VF8UmqWRDAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD14+f154_t1-TbbSDb9xV_ikDAWfF+8H7aOSK4VF8UmqWRDAQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ju Hyung Park <qkrwngud825@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/5/14 13:39, Ju Hyung Park wrote:
> On Wed, May 30, 2018 at 5:51 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>>
>> In the high utilization like over 80%, we don't expect huge # of large discard
>> commands, but do many small pending discards which affects FTL GCs a lot.
>> Let's issue them in that case.
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 6e40e536dae0..8c1f7a6bf178 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -915,6 +915,38 @@ static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
>> +                       dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;
> 
> Isn't this way too aggressive?
> 
> Discard thread will wake up on 50ms interval just because the user has
> used 80% of space.
> 60,000ms vs 50ms is too much of a stark difference.
> 
> I feel something like 10 seconds(10,000ms) could be a much more
> reasonable choice than this.

Hmm.. I agree that current hard code method is not flexible enough, and I
proposed below patch last year to adjust interval according to space usage, it
looks Jaegeuk partially agreed with that, and pointed out we need to distinguish
low/high-end storage to decide interval. And also you point out that btrfs
introduces mount option "ssd" to let user give the device type, and we can
distinguish with that. :P

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=009f548e37ca5d9b4cad9e3c15c2164c53eff1df

But I pended below patch based on Jaegeuk's and your idea due to other work...

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=47a992c12398c98e739e3eedc2743824459df943

Thanks,

> 
> Thanks.
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
