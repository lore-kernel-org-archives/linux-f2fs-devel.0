From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH 1/4] mkfs.f2fs: update extension lists
Date: Sat, 24 Mar 2018 15:55:19 +0900
Message-ID: <CAD14+f39mNqATcAyrbq-QN4hOh9QU=ZxRFTv3SyHOPDfdZDGkA@mail.gmail.com>
References: <20180317150257.123927-1-qkrwngud825@gmail.com>
 <1988f12a-351a-c137-2fc3-b68ce0aefc31@huawei.com>
 <CAD14+f3dRxjabWjzNQiOwCrqVyd-CjetcBGK-F+n=X5gEXp7ig@mail.gmail.com>
 <4ad8459b-2e69-e385-ee3a-f4e1ba33167c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1ezd5N-0008A9-Jt
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 24 Mar 2018 06:55:29 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail-ua0-f182.google.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1ezd5L-000g0L-21
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 24 Mar 2018 06:55:29 +0000
Received: by mail-ua0-f182.google.com with SMTP id v9so9153712uaj.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 23 Mar 2018 23:55:27 -0700 (PDT)
In-Reply-To: <4ad8459b-2e69-e385-ee3a-f4e1ba33167c@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

Sorry myself as well for the late reply :)
Got caught up with something.

> Like .so?

Yeah, that makes sense.
I've reran the command without the size limit.

>From Ubuntu, I think we can add '*.pyc' files as it's compiled Python
bytecode format.
>From Android, I saw some new '*.cnt' files which are just jpeg files.
Notably, Facebook, Skype, Tumblr and Twitter uses it.

Everything else seemed not that much interesting.

> I agree that we'd better support the superset list of common static file, but
> also I hope there is flexible usage of common list, old list and self defined
> list, so I think we'd better leave enough free space of cold list to let user
> define private cold file type extension as they wish, meanwhile support an
> option to make user have a chance to choose the common list or old list.

If I understood you correctly, you want to leave an option for the old list
so that users have more room to add many more extensions, correct?

If so, how about just leaving the old list and move the new ones to
the kernel code?
As I said in the previous comment, I don't think it makes sense to
ship new lists only to at the time of mkfs.
We can ship new lists as we update f2fs kernel code.

While the new version of f2fs allows users to dynamically add or
remove extensions,
it doesn't ship the new common lists.

Thanks.

On Wed, Mar 21, 2018 at 9:00 PM, Chao Yu <yuchao0@huawei.com> wrote:
> Hi Park,
>
> Sorry for late replying.
>
> On 2018/3/19 11:53, Ju Hyung Park wrote:
>> Hi Chao,
>>
>>> Do you run this script in android environment to get the cold type?
>> Yes, both on Ubuntu and Android(on /data with root permission).
>>
>>> Actually, I doubt that '+1M' condition can't indicate that the file is cold or
>>> not, and after run this script in my cell phone,
>> Would it make sense to set a file that's < 1M as cold?
>
> Like .so?
>
>> I didn't think so. Please let me know if I'm wrong.
>>
>>> I didn't see so many type as your patch adds.
>> Of course, most of those were added from vlc and p7zip.
>> There are tons more, but I added ones that are most common.
>> While I personally don't have that much many types myself as well,
>> I can easily see one having those extensions stored under f2fs.
>>
>> Previous list was not enough, imo.
>> (After running the command, I've added exo and ?dex files for Android.)
>>
>>> If that is a common cold file type list that user may not do random updates in
>>> the file after its creation,
>> That's exactly what I intended.
>>
>>> I suggest that we can add one common list instead
>>> of changing old one controlled by mkfs option
>> The new list is superset of the old list.
>> A few extensions were removed as those are mostly deprecated formats
>> and to make room for much more important extensions to be added such as m4a.
>
> I agree that we'd better support the superset list of common static file, but
> also I hope there is flexible usage of common list, old list and self defined
> list, so I think we'd better leave enough free space of cold list to let user
> define private cold file type extension as they wish, meanwhile support an
> option to make user have a chance to choose the common list or old list.
>
> How do you think?
>
> Hi Jaegeuk, what's your opinion?
>
> Thanks,
>
>>
>> Thanks.
>>
>>
>> On Mon, Mar 19, 2018 at 12:42 PM, Chao Yu <yuchao0@huawei.com> wrote:
>>> Hi Park,
>>>
>>> On 2018/3/17 23:02, Park Ju Hyung wrote:
>>>> Those formats are large in size and rarely updated.
>>>>
>>>> Formats such as tar and zip were intentionally excluded as
>>>> those are capable of random updates.
>>>>
>>>> (Added from vlc, p7zip and running
>>>> 'find . -type f -size +1M |
>>>>     while read FILE; do echo ${FILE##*.}; done |
>>>>     sort | uniq -c | sort -nr'
>>>> manually)
>>>
>>> Do you run this script in android environment to get the cold type?
>>>
>>> Actually, I doubt that '+1M' condition can't indicate that the file is cold or
>>> not, and after run this script in my cell phone, I didn't see so many type as
>>> your patch adds.
>>>
>>> If that is a common cold file type list that user may not do random updates in
>>> the file after its creation, I suggest that we can add one common list instead
>>> of changing old one controlled by mkfs option, anyway, to use which one, the
>>> option can be decided by user.
>>>
>>> Thanks,
>>>
>>>>
>>>> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
>>>> ---
>>>>  mkfs/f2fs_format.c | 86 ++++++++++++++++++++++++++++++++++++++++--------------
>>>>  1 file changed, 64 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>>>> index 65692bb..3c7ce16 100644
>>>> --- a/mkfs/f2fs_format.c
>>>> +++ b/mkfs/f2fs_format.c
>>>> @@ -37,34 +37,76 @@ struct f2fs_checkpoint *cp;
>>>>
>>>>  static unsigned int quotatype_bits = 0;
>>>>
>>>> -const char *media_ext_lists[] = {
>>>> -     "jpg",
>>>> -     "gif",
>>>> -     "png",
>>>> +const char *cold_ext_lists[] = {
>>>> +     /* video */
>>>>       "avi",
>>>>       "divx",
>>>> -     "mp4",
>>>> -     "mp3",
>>>> -     "3gp",
>>>> -     "wmv",
>>>> -     "wma",
>>>> -     "mpeg",
>>>> +     "flv",
>>>> +     "m2ts",
>>>> +     "m4p",
>>>> +     "m4v",
>>>>       "mkv",
>>>>       "mov",
>>>> -     "asx",
>>>> -     "asf",
>>>> -     "wmx",
>>>> -     "svi",
>>>> -     "wvx",
>>>> -     "wm",
>>>> +     "mp4",
>>>> +     "mpeg",
>>>> +     "mpeg4",
>>>>       "mpg",
>>>> -     "mpe",
>>>> -     "rm",
>>>>       "ogg",
>>>> +     "ogm",
>>>> +     "ogv",
>>>> +     "ts",
>>>> +     "vob",
>>>> +     "wmb",
>>>> +     "wmv",
>>>> +     "webm",
>>>> +
>>>> +     /* audio */
>>>> +     "aac",
>>>> +     "ac3",
>>>> +     "dts",
>>>> +     "flac",
>>>> +     "m4a",
>>>> +     "mka",
>>>> +     "mp3",
>>>> +     "oga",
>>>> +     "wav",
>>>> +     "wma",
>>>> +
>>>> +     /* image */
>>>> +     "bmp",
>>>> +     "gif",
>>>> +     "jpg",
>>>>       "jpeg",
>>>> -     "video",
>>>> -     "apk",  /* for android system */
>>>> -     "so",   /* for android system */
>>>> +     "png",
>>>> +     "svg",
>>>> +     "webp",
>>>> +
>>>> +     /* archive */
>>>> +     "7z",
>>>> +     "a",
>>>> +     "deb",
>>>> +     "gz",
>>>> +     "gzip",
>>>> +     "iso",
>>>> +     "jar",
>>>> +     "lzma",
>>>> +     "rar",
>>>> +     "tgz",
>>>> +     "txz",
>>>> +     "udf",
>>>> +     "xz",
>>>> +
>>>> +     /* other */
>>>> +     "pdf",
>>>> +     "ttf",
>>>> +     "ttc",
>>>> +
>>>> +     /* android */
>>>> +     "apk",
>>>> +     "exo", // YouTube
>>>> +     "odex", // Android RunTime
>>>> +     "vdex", // Android RunTime
>>>> +     "so",
>>>>       NULL
>>>>  };
>>>>
>>>> @@ -74,7 +116,7 @@ const char *hot_ext_lists[] = {
>>>>  };
>>>>
>>>>  const char **default_ext_list[] = {
>>>> -     media_ext_lists,
>>>> +     cold_ext_lists,
>>>>       hot_ext_lists
>>>>  };
>>>>
>>>>
>>>
>>
>> .
>>
>

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
