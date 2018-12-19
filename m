From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: flush stale issued discard
 candidates
Date: Wed, 19 Dec 2018 11:21:53 +0800
Message-ID: <b878570b-1e71-ab32-20a6-dd262f21348a@huawei.com>
References: <20181214050127.45025-1-jaegeuk@kernel.org>
 <20181214050127.45025-3-jaegeuk@kernel.org>
 <639940cc-f7a8-e679-3b28-3b3b2485652b@huawei.com>
 <20181218224351.GC31062@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218224351.GC31062@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/12/19 6:43, Jaegeuk Kim wrote:
> On 12/18, Chao Yu wrote:
>> On 2018/12/14 13:01, Jaegeuk Kim wrote:
>>> Sometimes, I could observe # of issuing_discard to be 1 which blocks background
>>> jobs due to is_idle()=false.
>>> The only way to get out of it was to trigger gc_urgent. This patch avoids that
>>> by checking any candidates as done in the list.
>>
>> Well, as below code, once we issued discard commands, we will wait all
>> queued discard end their IO, so do you know what flow can cause such
>> condition...?
> 
> It's very subtle, and I suspect somehow race condition not from here.
> 
>>
>> 		issued = __issue_discard_cmd(sbi, &dpolicy);
>> 		if (issued > 0) {
>> 			__wait_all_discard_cmd(sbi, &dpolicy);
>>
>> Or, I doubt that 'issued' statistical info could be wrong.
> 
> No, it simply came back to 0 with this patch. So, something is pending
> in the queue even if it is done.

__submit_discard_cmd()
{
....
	dc->len = 0;   <---- reset discard length here

	while (total_len && *issued < dpolicy->max_requests && !err) {
		struct bio *bio = NULL;
		unsigned long flags;
		bool last = true;

		if (len > max_discard_blocks) {
			len = max_discard_blocks;  <---- will truncate len to max_discard_blocks
			last = false;
		}

		(*issued)++;
		if (*issued == dpolicy->max_requests)
			last = true;

		dc->len += len;      <----- will update len into dc->len
...
}

__wait_discard_cmd_range()
{
...
		if (dc->len < dpolicy->granularity)
			continue;
So we can only remove discard entry which size is not smaller than
dpolicy->granularity, if max_discard_blocks is smaller than granularity,
after splitting discard in __submit_discard_cmd(), we may left small-sized
entry there.

...
}

Could you check that whether the left discard was skipped being removed due
to above reason?

Thanks

> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/segment.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 49ea9009ab5a..acbbc924e518 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -1651,6 +1651,10 @@ static int issue_discard_thread(void *data)
>>>  		if (dcc->discard_wake)
>>>  			dcc->discard_wake = 0;
>>>  
>>> +		/* clean up pending candidates before going to sleep */
>>> +		if (atomic_read(&dcc->queued_discard))
>>> +			__wait_all_discard_cmd(sbi, NULL);
>>> +
>>>  		if (try_to_freeze())
>>>  			continue;
>>>  		if (f2fs_readonly(sbi->sb))
>>>
> 
> .
> 
