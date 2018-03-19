From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH 1/4] mkfs.f2fs: update extension lists
Date: Mon, 19 Mar 2018 12:53:06 +0900
Message-ID: <CAD14+f3dRxjabWjzNQiOwCrqVyd-CjetcBGK-F+n=X5gEXp7ig@mail.gmail.com>
References: <20180317150257.123927-1-qkrwngud825@gmail.com>
 <1988f12a-351a-c137-2fc3-b68ce0aefc31@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1exlrH-0001so-AP
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Mar 2018 03:53:15 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail-vk0-f66.google.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1exlrF-002coS-EA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Mar 2018 03:53:15 +0000
Received: by mail-vk0-f66.google.com with SMTP id x5so8333951vkd.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 18 Mar 2018 20:53:13 -0700 (PDT)
In-Reply-To: <1988f12a-351a-c137-2fc3-b68ce0aefc31@huawei.com>
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

> Do you run this script in android environment to get the cold type?
Yes, both on Ubuntu and Android(on /data with root permission).

> Actually, I doubt that '+1M' condition can't indicate that the file is cold or
> not, and after run this script in my cell phone,
Would it make sense to set a file that's < 1M as cold?
I didn't think so. Please let me know if I'm wrong.

> I didn't see so many type as your patch adds.
Of course, most of those were added from vlc and p7zip.
There are tons more, but I added ones that are most common.
While I personally don't have that much many types myself as well,
I can easily see one having those extensions stored under f2fs.

Previous list was not enough, imo.
(After running the command, I've added exo and ?dex files for Android.)

> If that is a common cold file type list that user may not do random updates in
> the file after its creation,
That's exactly what I intended.

> I suggest that we can add one common list instead
> of changing old one controlled by mkfs option
The new list is superset of the old list.
A few extensions were removed as those are mostly deprecated formats
and to make room for much more important extensions to be added such as m4a.

Thanks.


On Mon, Mar 19, 2018 at 12:42 PM, Chao Yu <yuchao0@huawei.com> wrote:
> Hi Park,
>
> On 2018/3/17 23:02, Park Ju Hyung wrote:
>> Those formats are large in size and rarely updated.
>>
>> Formats such as tar and zip were intentionally excluded as
>> those are capable of random updates.
>>
>> (Added from vlc, p7zip and running
>> 'find . -type f -size +1M |
>>     while read FILE; do echo ${FILE##*.}; done |
>>     sort | uniq -c | sort -nr'
>> manually)
>
> Do you run this script in android environment to get the cold type?
>
> Actually, I doubt that '+1M' condition can't indicate that the file is cold or
> not, and after run this script in my cell phone, I didn't see so many type as
> your patch adds.
>
> If that is a common cold file type list that user may not do random updates in
> the file after its creation, I suggest that we can add one common list instead
> of changing old one controlled by mkfs option, anyway, to use which one, the
> option can be decided by user.
>
> Thanks,
>
>>
>> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
>> ---
>>  mkfs/f2fs_format.c | 86 ++++++++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 64 insertions(+), 22 deletions(-)
>>
>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>> index 65692bb..3c7ce16 100644
>> --- a/mkfs/f2fs_format.c
>> +++ b/mkfs/f2fs_format.c
>> @@ -37,34 +37,76 @@ struct f2fs_checkpoint *cp;
>>
>>  static unsigned int quotatype_bits = 0;
>>
>> -const char *media_ext_lists[] = {
>> -     "jpg",
>> -     "gif",
>> -     "png",
>> +const char *cold_ext_lists[] = {
>> +     /* video */
>>       "avi",
>>       "divx",
>> -     "mp4",
>> -     "mp3",
>> -     "3gp",
>> -     "wmv",
>> -     "wma",
>> -     "mpeg",
>> +     "flv",
>> +     "m2ts",
>> +     "m4p",
>> +     "m4v",
>>       "mkv",
>>       "mov",
>> -     "asx",
>> -     "asf",
>> -     "wmx",
>> -     "svi",
>> -     "wvx",
>> -     "wm",
>> +     "mp4",
>> +     "mpeg",
>> +     "mpeg4",
>>       "mpg",
>> -     "mpe",
>> -     "rm",
>>       "ogg",
>> +     "ogm",
>> +     "ogv",
>> +     "ts",
>> +     "vob",
>> +     "wmb",
>> +     "wmv",
>> +     "webm",
>> +
>> +     /* audio */
>> +     "aac",
>> +     "ac3",
>> +     "dts",
>> +     "flac",
>> +     "m4a",
>> +     "mka",
>> +     "mp3",
>> +     "oga",
>> +     "wav",
>> +     "wma",
>> +
>> +     /* image */
>> +     "bmp",
>> +     "gif",
>> +     "jpg",
>>       "jpeg",
>> -     "video",
>> -     "apk",  /* for android system */
>> -     "so",   /* for android system */
>> +     "png",
>> +     "svg",
>> +     "webp",
>> +
>> +     /* archive */
>> +     "7z",
>> +     "a",
>> +     "deb",
>> +     "gz",
>> +     "gzip",
>> +     "iso",
>> +     "jar",
>> +     "lzma",
>> +     "rar",
>> +     "tgz",
>> +     "txz",
>> +     "udf",
>> +     "xz",
>> +
>> +     /* other */
>> +     "pdf",
>> +     "ttf",
>> +     "ttc",
>> +
>> +     /* android */
>> +     "apk",
>> +     "exo", // YouTube
>> +     "odex", // Android RunTime
>> +     "vdex", // Android RunTime
>> +     "so",
>>       NULL
>>  };
>>
>> @@ -74,7 +116,7 @@ const char *hot_ext_lists[] = {
>>  };
>>
>>  const char **default_ext_list[] = {
>> -     media_ext_lists,
>> +     cold_ext_lists,
>>       hot_ext_lists
>>  };
>>
>>
>

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
