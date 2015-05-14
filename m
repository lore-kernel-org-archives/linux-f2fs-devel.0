From: Tom Marshall <tom@cyngn.com>
Subject: Re: [PATCH 03/18] f2fs crypto: declare some definitions for f2fs
 encryption feature
Date: Thu, 14 May 2015 09:50:44 -0700
Message-ID: <5554D264.7070105@cyngn.com>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org> <1431145253-2019-3-git-send-email-jaegeuk@kernel.org> <20150513020208.GK15721@dastard> <20150513064802.GA48682@jaegeuk-mac02.hsd1.ca.comcast.net> <20150514003721.GN15721@dastard> <20150514015643.GA70216@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150514015643.GA70216@jaegeuk-mac02>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Please keep in mind that I'm also working on transparent compression.  
I'm watching this thread closely so that I can implement a compression 
library alongside the crypto library.  If there is any interest or 
benefit, I would be glad to work together so that the two can be done 
cooperatively at the same time.

On 05/13/2015 06:56 PM, Jaegeuk Kim wrote:
> On Thu, May 14, 2015 at 10:37:21AM +1000, Dave Chinner wrote:
>> On Tue, May 12, 2015 at 11:48:02PM -0700, Jaegeuk Kim wrote:
>>> On Wed, May 13, 2015 at 12:02:08PM +1000, Dave Chinner wrote:
>>>> On Fri, May 08, 2015 at 09:20:38PM -0700, Jaegeuk Kim wrote:
>>>>> This definitions will be used by inode and superblock for encyption.
>>>> How much of this crypto stuff is common with or only slightly
>>>> modified from the ext4 code?  Is the behaviour and features the
>>>> same? Is the user API and management tools the same?
>>>>
>>>> IMO, if there is any amount of overlap, then we should be
>>>> implementing this stuff as generic code, not propagating the same
>>>> code through multiple filesystems via copy-n-paste-n-modify. This
>>>> will simply end up with diverging code, different bugs and feature
>>>> sets, and none of the implementations will get the review and
>>>> maintenance they really require...
>>>>
>>>> And, FWIW, this is the reason why I originally asked for the ext4
>>>> encryption code to be pulled up to the VFS: precisely so we didn't
>>>> end up with a rapid proliferation of individual in-filesystem
>>>> encryption implementations that are all slightly different...
>>> Totally agreed!
>>>
>>> AFAIK, Ted wants to push the codes as a crypto library into fs/ finally, so
>>> I believe most part of crypto codes are common.
>> Can I suggest fs/crypto/ if there are going to be multiple files?
> No problem at all. I'll do.
>
>>> But, in order to realize that quickly, Ted implemented the feature to finalize
>>> on-disk and in-memory design in EXT4 as a first step.
>>> Then, I've been catching up and validating its design by implementing it in
>>> F2FS, which also intends to figure out what crypto codes can be exactly common.
>> Excellent. That will make it easier and less error prone for other
>> filesystems to implement it, too!
>>
>>> As Ted mentioned before, since next android version tries to use per-file
>>> encryption, F2FS also needs to support it as quick as possible likewise EXT4.
>> Fair enough.
>>
>>> Meanwhile, surely I've been working on writing patches to push them into fs/;
>>> currenlty, I did for cryto.c and will do for crypto_key.c and crypto_fname.c.
>>> But, it needs to think about crypto_policy.c differently, since it may depend
>>> on how each filesystem stores the policy information respectively; we cannot
>>> push all the filesystems should use xattrs, right?
>> All filesystems likely to implement per-file crypto support xattrs,
>> and this is exactly what xattrs are designed for. e.g. we already
>> require xattrs for generic security labels, ACLs, etc. Hence
>> per-file crypto information should also use a common, shared xattr
>> format. That way it only needs to be implemented once in the generic
>> code and there's very little (hopefully nothing!) each filesystem
>> has to customise to store the crypto information for each file.
> Ok, I see. Let me take a look at that too.
> Thank you for sharing your thoughts. :)
>
>> Cheers,
>>
>> Dave.
>> -- 
>> Dave Chinner
>> david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
